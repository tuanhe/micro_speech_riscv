# micro_speech_riscv

tensorflow-lite micro runs on Sifive FE310-G002(risc-v)  
use the 
```
  make
```
it will build the static lib
next 
```
gcc -c micro_speech_lib_test.c -o lib_test.o
```
to build the test code 
then link the static lib 
```
g++ -o lib_test lib_test.o -L. libmicro_speech.a
```


