# Impersonate

pretend to be a gen_server, etc

## Installation

```elixir
def deps do
  [{:impersonate, "~> 0.1.0", github: "wistia/impersonate_ex"}]
end
```

## Usage

```ex
require Impersonate.GenServer

test "do thing" do
  parent = self()
  spawn_link fn -> :ok = GenServer.call(parent, :do_thing) end
  Impersonate.GenServer.handle_call(fn :do_thing -> :ok end)
end
```
