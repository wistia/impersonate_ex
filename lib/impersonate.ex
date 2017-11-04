defmodule Impersonate do
  defmodule GenServer do
    @moduledoc """
    Handle calls, etc like a GenServer does:

    ## Example

    defmodule MyModule do
      require Impersonate.GenServer

      def test_something do
        parent = self()
        spawn_link fn -> :ok = GenServer.call(parent, :do_thing) end
        Impersonate.GenServer.handle_call(fn :do_thing -> :ok end)
      end
    end
    """

    defmacro handle_call(handler, timeout \\ 100) do
      quote do
        receive do
          {:"$gen_call", {to, tag}, msg} ->
            case unquote(handler).(msg) do
              {:reply, reply} -> send(to, {tag, reply})
              :noreply -> :ok
              reply -> send(to, {tag, reply})
            end
        after
          unquote(timeout) -> raise "timeout"
        end
      end
    end

    defmacro assert_receive_call(match) do
      quote do
        assert_receive {:"$gen_call", {_, _}, unquote(match)}
      end
    end

    defmacro assert_received_call(match) do
      quote do
        assert_received {:"$gen_call", {_, _}, unquote(match)}
      end
    end

    defmacro refute_receive_call(match) do
      quote do
        refute_receive {:"$gen_call", {_, _}, unquote(match)}
      end
    end

    defmacro refute_received_call(match) do
      quote do
        refute_received {:"$gen_call", {_, _}, unquote(match)}
      end
    end
  end
end
