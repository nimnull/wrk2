#!/usr/bin/env bash

docker run --rm -v /Users/Nazarkin/workspace:/opt --net host lua_wrk2 -s /opt/test.lua -R10 http://10.0.0.2 -- predict.csv
