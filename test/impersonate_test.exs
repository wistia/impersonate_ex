defmodule ImpersonateTest do
  use ExUnit.Case
  doctest Impersonate
  require Impersonate.GenServer

  describe "assert_receive_call/1" do
    test "matches the pattern" do
      parent = self()
      Task.async(fn -> GenServer.call(parent, {:hello, :world}) end)
      Impersonate.GenServer.assert_receive_call {:hello, :world}
    end
  end

  describe "assert_received_call/1" do
    test "matches the pattern" do
      parent = self()
      Task.async(fn -> GenServer.call(parent, {:hello, :world}) end)
      Process.sleep(100)
      Impersonate.GenServer.assert_received_call {:hello, :world}
    end
  end

  describe "refute_receive_call/1" do
    test "matches the pattern" do
      parent = self()
      Task.async(fn -> GenServer.call(parent, {:hello, :world}) end)
      Impersonate.GenServer.refute_receive_call {:hello, :furld}
    end
  end

  describe "refute_received_call/1" do
    test "matches the pattern" do
      parent = self()
      Task.async(fn -> GenServer.call(parent, {:hello, :world}) end)
      Impersonate.GenServer.refute_received_call {:hello, :furld}
    end
  end
end
