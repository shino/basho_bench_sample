-module(basho_bench_driver_file_write).

-export([new/1,
         run/4]).

-include_lib("basho_bench/include/basho_bench.hrl").

-record(state, {file}).

new(_Id) ->
  File = basho_bench_config:get(file_name, "file_write_test.txt"),
  {ok, Io} = file:open(File, [append]),
  {ok, #state{file = Io}}.

run(write, KeyGen, ValueGen, State) ->
  Key = KeyGen(),
  Value = ValueGen(),
  file:write(State#state.file,
             [integer_to_list(Key), <<":">>, base64:encode(Value), <<$\n>>]),
  {ok, State};
run(writedatasync, KeyGen, ValueGen, State) ->
  Key = KeyGen(),
  Value = ValueGen(),
  file:write(State#state.file,
             [integer_to_list(Key), <<":">>, base64:encode(Value), <<$\n>>]),
  file:datasync(State#state.file),
  {ok, State}.
