#!/bin/bash

sleep 10
erl -sname srv0 -setcookie devcookie -detached -noinput &
/bin/sh -c "while true; do sleep 2; done"
