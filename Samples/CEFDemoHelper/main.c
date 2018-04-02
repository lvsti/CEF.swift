//
//  main.c
//  CEFDemo Helper
//
//  Created by Tamas Lustyik on 2017. 11. 12..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

#include "include/capi/cef_app_capi.h"

int main(int argc, char* argv[]) {
    cef_main_args_t mainArgs = {.argc = argc, .argv = argv };
    
    return cef_execute_process(&mainArgs, NULL, NULL);
}

