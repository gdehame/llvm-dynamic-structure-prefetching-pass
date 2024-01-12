#!/bin/bash

sed \
    -e 's|Symbol_1108|array3|g' \
    -e 's|Symbol_905|array32|g' \
    -e 's|Symbol_896|num_iter|g' \
    -e 's|Symbol_889|num_iter|g' \
    -e 's|Symbol_888|position|g' \
    -e 's|Symbol_759|struct1_aux|g' \
    -e 's|Symbol_664|num_iter|g' \
    -e 's|Symbol_549|array_aux|g' \
    -e 's|Symbol_548|i|g' \
    -e 's|Symbol_539|i|g' \
    -e 's|Symbol_263|bench1func|g' \
    -e 's|Symbol_264|bench2func|g' \
    -e 's|Symbol_274|bench3func|g' \
    -e 's|Symbol_256|Struct1|g' \
    -e 's|Symbol_213|Func1|g' \
    -e 's|Symbol_75|Array32|g' \
    -e 's|Symbol_74|Array3|g' \
    -e 's|Symbol_21|getNumIter|g' \
    benchmarks_symbols.c > benchmarks.c 
