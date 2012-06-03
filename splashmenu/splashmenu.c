/*
 * Copyright (C) 2007-2011 The Android Open Source Project
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

#include <errno.h>
#include <linux/input.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include <unistd.h>

#include "common.h"
#include "minui/minui.h"
#include "splashmenu_ui.h"


enum { 
  BUTTON_ERROR,
  BUTTON_PRESSED,
  BUTTON_TIMEOUT,
};


/**
 * compare_string()
 *
 */
static int compare_string(const void* a, const void* b) {
  return strcmp(*(const char**)a, *(const char**)b);
}


/**
 * wait_key()
 *
 */
static int wait_key(int key, int skipkey) {
  int i;
  int result = 0;
  int keyp = 0;

  for(i=0; i < 400; i++) {
    keyp = ui_key_pressed(key, skipkey);
    if(keyp != 0) {
      result = keyp;
      break;
    }
    else {
      usleep(20000); //20ms * 400 = 8sec
    }
  }

  return result;
}



int main(int argc, char **argv) {
  int defmode, mode, status = BUTTON_ERROR;
  int result = 1;

  LOGI("Starting Safestrap Splash\n");

  ui_init();

  if (argc == 2 && 0 == strcmp(argv[1], "1")) {
      ui_set_background(BACKGROUND_ALT);
  } else {
      ui_set_background(BACKGROUND_DEFAULT);
  }

  ui_show_text(1);

  int keyp = wait_key(KEY_MENU, KEY_SEARCH);
  status = ((keyp == KEY_MENU) ? BUTTON_PRESSED : BUTTON_TIMEOUT);

  if (status == BUTTON_PRESSED) {
      result = 0;
  }

  ui_set_background(BACKGROUND_BLANK);
  ui_final();

  sync();
  LOGI("result: %d\n", result);
  exit(result);
}

