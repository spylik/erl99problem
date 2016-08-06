PROJECT = erl99problems

SHELL_DEPS = sync

dep_sync = git https://github.com/rustyio/sync

SHELL_OPTS = -pa ebin/ test/ -env ERL_LIBS deps -eval 'code:ensure_loaded(erl99problems), code:ensure_loaded(erl99problems_tests), ok = sync:go(), RunTests = fun(Mods) -> _ = [Mod:test() || Mod <- Mods, erlang:function_exported(Mod, test, 0)], [eunit:test(Mod) || Mod <- Mods] end, sync:onsync(RunTests)'

include erlang.mk
