.PHONY: deps

all: deps compile
	make -C deps/basho_bench all
	cp deps/basho_bench/basho_bench .

deps:
	./rebar get-deps

compile: deps
	./rebar compile

clean:
	@./rebar clean
	rm -f ./basho_bench

results:
	./deps/basho_bench/priv/summary.r -i tests/current
