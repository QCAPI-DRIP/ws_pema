#!/bin/bash
if [ ! -z "$VIRTUAL_ENV" ]; then
    python3 setup.py develop
else
    echo "No virtual environment detected, you have to take care of running python setup.py install or setup.py develop yourself!">&2
fi
clamservice -d pema.pema
