#!/bin/bash

flex analex.l
echo 'flex ready!\n'

bison -d -t anasin.y
echo 'bison ready!\n'

gcc lex.yy.c anasin.tab.c
./a.out
echo 'insert your input:'
