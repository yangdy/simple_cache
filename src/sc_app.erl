%%%-------------------------------------------------------------------
%%% @auth yangdy <anvilhorn@163.com>
%%%  [http://github.com/yangdy]
%%% @copyright 2015 yangdy
%%%-------------------------------------------------------------------
-module(sc_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    sc_store:init(),
    case sc_sup:start_link() of
	{ok, Pid} ->
	    {ok, Pid};
	Reason ->
	    {error, Reason}
    end.

stop(_State) ->
    ok.
