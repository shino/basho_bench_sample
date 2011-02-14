-module(basho_bench_sample_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    basho_bench_sample_sup:start_link().

stop(_State) ->
    ok.
