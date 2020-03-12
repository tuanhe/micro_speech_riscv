/***************************************
 * This is test demo usd for test static lib works or not 
 * by the build command :
 * "gcc -c micro_speech_lib_test.c -o lib_test.o"
 * Then
 * "g++ -o lib_test lib_test.o -L. libmicro_speech.a"
 * Next
 * "./lib_test"
 * **************************************/

#include <stdio.h> 
#include "micro_speech_interface.h"

int main(void)
{
printf("begin to use micro speech C++ libary\n");
micro_speech_lib_test();
printf("After to use micro speech C++ libary\n");

return 0;


}