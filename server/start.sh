#!/bin/sh
cd `dirname $0`
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -config tracktrain.config -boot start_sasl -s reloader -s tracktrain
