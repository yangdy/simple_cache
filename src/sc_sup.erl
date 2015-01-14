%%%-------------------------------------------------------------------
%%% @author yangdy <anvilhorn@163.com>
%%%  [http://github.com/yangdy]
%%% @copyright 2015 yangdy
%%%-------------------------------------------------------------------
-module(sc_sup).

-behaviour(supervisor).

-export([start_link/0,
	 start_child/2
	]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_child(Value, LeaseTime) ->
    supervisor:start_child(?SERVER, [Value, LeaseTime]).

init([]) ->
    Element = {sc_element, {sc_element, start_link, []},
	       temporary, brutal_kill, worker, [sc_element]},
    Children = [Element],
    RestartStrategy = {simple_one_for_one, 0, 1},
    {ok, {RestartStrategy, Children}}.
