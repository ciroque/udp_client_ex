defmodule DatagramTest do
  use ExUnit.Case

  test "too long message returns error" do
    message = random_string(1111111)
    assert {:error, :message_too_long} == Datagram.prepare_message(message)
  end

  test "short message yields single element list" do
    message = "This is my message"
    {:ok, datagrams} = Datagram.prepare_message(message)
    assert length(datagrams) == 1
  end

  test "long message yields two element list" do
    message = random_string(12000)
    {:ok, datagrams} = Datagram.prepare_message(message)
    assert length(datagrams) == 2
  end

  test "long message yields 4 element list" do
    message = random_string(57200)
    {:ok, datagrams} = Datagram.prepare_message(message)
    assert length(datagrams) == 7
  end

  def random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
