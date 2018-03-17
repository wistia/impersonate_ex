# impersonate_ex

pretend to be a gen_server, etc

## Why?

We often want to test message passing in our code. `impersonate_ex` implements the same interfaces as your OTP components allowing you to swap in your own mock handlers to intimately test the protocols and handling in your components.

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
