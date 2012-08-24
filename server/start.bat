SET ERL_LIBS=%cd%\deps
echo %ERL_LIBS%
erl -pa ./ebin ./deps/*/ebin -boot start_sasl -s tracktrain
PAUSE