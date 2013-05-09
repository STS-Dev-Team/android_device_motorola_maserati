/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#define LOG_TAG "lights"

#include <cutils/log.h>
#include <cutils/properties.h>

#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>

#include <sys/ioctl.h>
#include <sys/types.h>

#include <hardware/lights.h>

/******************************************************************************/

#define CHARGE_LED_OFF   0
#define CHARGE_LED_RGB   1
#define CHARGE_LED_WHITE 2

#define HAVE_KEYBOARD

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;

static struct light_state_t g_battery;
static struct light_state_t g_notification;
static int g_charge_led_active;
static int g_last_button_brightness;
static int g_last_keyboard_brightness;
static int g_last_caps_brightness;

char const*const LCD_FILE = "/sys/class/backlight/lm3532_bl/brightness";
char const*const BUTTON_ON_FILE = "/sys/class/leds/button-backlight/brightness";
char const*const KEYBOARD_FILE = "/sys/class/leds/keyboard-backlight/brightness";
char const*const KEYBOARD_SHIFT_FILE = "/sys/class/leds/shift-key-light/brightness";

/* RGB file descriptors */
char const*const RED_LED_FILE = "/sys/class/leds/red/brightness";
char const*const RED_BLINK_FILE = "/sys/class/leds/red/blink";
char const*const GREEN_LED_FILE = "/sys/class/leds/green/brightness";
char const*const BLUE_LED_FILE = "/sys/class/leds/blue/brightness";

void init_globals(void)
{
    // init the mutex
    pthread_mutex_init(&g_lock, NULL);
    memset(&g_battery, 0, sizeof(g_battery));
    memset(&g_notification, 0, sizeof(g_notification));

    g_charge_led_active = 0;
    g_last_button_brightness = -1;
    g_last_keyboard_brightness = -1;
    g_last_caps_brightness = -1;
}

static int
write_int(char const* path, int value)
{
    int fd;
    static int already_warned = 0;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buffer[20];
        int bytes = sprintf(buffer, "%d\n", value);
        int amt = write(fd, buffer, bytes);
        close(fd);
        return amt == -1 ? -errno : 0;
    } else {
        if (already_warned == 0) {
            ALOGE("write_int failed to open %s\n", path);
            already_warned = 1;
        }
        return -errno;
    }
}

static int
is_lit(struct light_state_t const* state)
{
    return state->color & 0x00ffffff;
}

static int
rgb_to_brightness(struct light_state_t const* state)
{
    int red = (state->color >> 16) & 0xff;
    int green = (state->color >> 8) & 0xff;
    int blue = state->color & 0xff;

    return ((77 * red) + (150 * green) + (29 * blue)) >> 8;
}

static int
set_light_backlight(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);
    err = write_int(LCD_FILE, brightness);
    pthread_mutex_unlock(&g_lock);

    return err;
}

static int
set_light_keyboard(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);

    if (g_last_keyboard_brightness < 0 ||
        (g_last_keyboard_brightness == 0 && brightness > 0) ||
        (g_last_keyboard_brightness > 0 && brightness == 0))
    {
        err = write_int(KEYBOARD_FILE, brightness);
    }

    g_last_keyboard_brightness = brightness;

    pthread_mutex_unlock(&g_lock);

    return err;

}

static int
set_light_caps(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);

    if (g_last_caps_brightness < 0 ||
        (g_last_caps_brightness == 0 && brightness > 0) ||
        (g_last_caps_brightness > 0 && brightness == 0))
    {
        err = write_int(KEYBOARD_SHIFT_FILE, brightness ? 255 : 0);
    }

    g_last_caps_brightness = (brightness ? 255 : 0);

    pthread_mutex_unlock(&g_lock);

    return err;
}

static int
set_light_buttons(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int brightness = rgb_to_brightness(state);

    pthread_mutex_lock(&g_lock);

    if (g_last_button_brightness < 0 ||
        (g_last_button_brightness == 0 && brightness > 0) ||
        (g_last_button_brightness > 0 && brightness == 0))
    {
        err = write_int(BUTTON_ON_FILE, brightness ? 255 : 0);
    }

    g_last_button_brightness = brightness;

    pthread_mutex_unlock(&g_lock);

    return err;

}

static int
set_light_locked(struct light_device_t *dev, struct light_state_t *state)
{
    int err = 0;
    int red, green, blue;

    red = (state->color >> 16) & 0xFF;
    green = (state->color >> 8) & 0xFF;
    blue = state->color & 0xFF;

    // ensure blinking is off
    err = write_int(RED_BLINK_FILE, 0);

    // set colors
    err = write_int(RED_LED_FILE, red);
    err = write_int(GREEN_LED_FILE, green);
    err = write_int(BLUE_LED_FILE, blue);

    // blink if supposed to
    if (state->flashMode != LIGHT_FLASH_NONE) {
        err = write_int(RED_BLINK_FILE, 255);
    }

    return err;
}


static int
handle_light_locked(struct light_device_t *dev)
{
    int retval = 0;
    int show_charge = g_charge_led_active;

    if (is_lit(&g_notification)) {
        retval = set_light_locked(dev, &g_notification);
        show_charge = 0;
    } else {
        retval = set_light_locked(dev, &g_battery);
    }

    return retval;
}

static int
set_light_battery(struct light_device_t* dev,
        struct light_state_t const* state)
{
    pthread_mutex_lock(&g_lock);

    g_battery = *state;
    handle_light_locked(dev);
    pthread_mutex_unlock(&g_lock);

    return 0;
}

static int
set_light_notification(struct light_device_t* dev,
        struct light_state_t const* state)
{
    pthread_mutex_lock(&g_lock);
    g_notification = *state;
    handle_light_locked(dev);
    pthread_mutex_unlock(&g_lock);

    return 0;
}

static int
set_light_attention(struct light_device_t* dev,
        struct light_state_t const* state)
{
    /* we don't have an attention light */
    return 0;
}

static int
close_lights(struct light_device_t *dev)
{
    if (dev) {
        free(dev);
    }
    return 0;
}


/******************************************************************************/
static int open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name)) {
        set_light = set_light_backlight;
    }
    else if (0 == strcmp(LIGHT_ID_KEYBOARD, name)) {
        set_light = set_light_keyboard;
    }
    else if (0 == strcmp(LIGHT_ID_CAPS, name)) {
        set_light = set_light_caps;
    }
    else if (0 == strcmp(LIGHT_ID_BUTTONS, name)) {
        set_light = set_light_buttons;
    }
    else if (0 == strcmp(LIGHT_ID_BATTERY, name)) {
        set_light = set_light_battery;
    }
    else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name)) {
        set_light = set_light_notification;
    }
    else if (0 == strcmp(LIGHT_ID_ATTENTION, name)) {
        set_light = set_light_attention;
    }
    else {
        ALOGW("%s: unknown led id %s", __FUNCTION__, name);
        return -EINVAL;
    }

    pthread_once(&g_init, init_globals);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->common.close = (int (*)(struct hw_device_t*))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*)dev;
    return 0;
}


static struct hw_module_methods_t lights_module_methods = {
    .open =  open_lights,
};

struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "OMAP4 lights Module",
    .author = "STS-Dev-Team, AOSP, Google",
    .methods = &lights_module_methods,
};
