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

    defmacro handle_call(handler) do
      quote do
        receive do
          {:"$gen_call", {to, tag}, msg} ->
            case unquote(handler).(msg) do
              {:reply, reply} -> send(to, {tag, reply})
              :noreply -> :ok
              reply -> send(to, {tag, reply})
            end
        end
      end
    end
  end
end
