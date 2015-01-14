%%%-------------------------------------------------------------------
%%% @author yangdy <anvilhorn@163.com>
%%%  [http://github.com/yangdy]
%%% @copyright 2015 yangdy
%%%-------------------------------------------------------------------
-module(simple_cache).

-export([insert/2, lookup/1, delete/1]).

insert(Key, Value) ->
    case sc_store:lookup(Key) of
	{ok, Pid} ->
	    sc_element:replace(Pid, Value);
	{error, _} ->
	    {ok, Pid} = sc_element:create(Value),
	    sc_store:insert(Key, Pid)
    end.

lookup(Key) ->
    try
	{ok, Pid} = sc_store:lookup(Key),
	{ok, Value} = sc_element:fetch(Pid),
	{ok, Value}
    catch
	_ErrorClass:_Reason ->
	    {error, not_found}
    end.

delete(Key) ->
    case sc_store:lookup(Key) of
	{ok, Pid} ->
	    sc_element:delete(Pid);
	{error, _Reason} ->
	    ok
    end.
