#!/bin/bash

./node_modules/stylus/bin/stylus ../_css-source/main.styl ../_css-source/posts/* $@ -I ./node_modules/nib/lib -o ../css/

