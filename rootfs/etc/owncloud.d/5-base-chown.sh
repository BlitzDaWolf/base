#!/usr/bin/env bash

find /mnt \( \! -user www-data -o \! -group root \) -print0 | xargs -r -0 chown www-data:root