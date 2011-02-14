-module(tcp_server_echo).
-behaviour(tcp_server).

-export([start_link/2, stop/0]).
-export([init/1, handle_call/3]).

-include_lib("tcp_server/include/tcp_server.hrl").

%% Origianl version at http://d.hatena.ne.jp/cooldaemon/20081205/1228451785

%% I/F
start_link(Port, MaxProcesses) ->
  tcp_server:start_link(
    ?MODULE, [],
    #tcp_server_option{listen = [{active, false},
                                 binary,
                                 {packet, 4},
                                 {reuseaddr, true}],
                       port = Port,
                       max_processes = MaxProcesses}).
stop() ->
  tcp_server:stop().

%% Callbacks
init(_Args) ->
  {ok, {}}.

handle_call(_Socket, <<"bye\r\n">>, State) ->
  {close, <<"cya\r\n">>, State};
handle_call(_Socket, Data, State) ->
  {reply, Data, State}.
