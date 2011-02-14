-module(basho_bench_driver_tcp_server_echo).

-export([new/1,
         run/4]).

-include_lib("basho_bench/include/basho_bench.hrl").
-include_lib("eunit/include/eunit.hrl").

-record(state, {socket}).
-define(PORT, 8453).
-define(TIMEOUT, 10000). % 10 seconds

new(Id) ->
  initialize_global(Id),
  %% TODO: Error handling of timeout  2011/02/15 by shino
  Socket = connect(),
  {ok, #state{socket = Socket}}.

run(ping, _KeyGen, ValueGen, State) ->
  Value = ValueGen(),
  ok = gen_tcp:send(State#state.socket, Value),
  %% Confirm received data is the same as sent one.
  %% TODO: Error handling of timeout  2011/02/15 by shino
  {ok, Value} = gen_tcp:recv(State#state.socket, 0, ?TIMEOUT),
  {ok, State}.

initialize_global(1) ->
  ?INFO("initialize_global, executed once and only once.\n", []),
  MaxProcesses = basho_bench_config:get(max_server_processes, 5),
  tcp_server_echo:start_link(?PORT, MaxProcesses);
initialize_global(_Id) ->
  ok.

connect() ->
  {ok, Socket} = gen_tcp:connect({127, 0, 0, 1},
                                 ?PORT,
                                 [binary,
                                  {active, false},
                                  {packet, 4}],
                                 ?TIMEOUT),
  Socket.
