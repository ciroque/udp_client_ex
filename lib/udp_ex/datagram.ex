defmodule Datagram do
  @moduledoc """
  Handles preparing a message for transmission
  """

  require Logger

  @max_message_size 1_047_040
  @max_packet_size 8192
  @max_payload_size 8180

  @doc """
  Given a message to send handles preparing the message to be sent via UDP.
  This may involve breaking the message into smaller pieces that can be handled by UDP.

  Presently the message is expected to be binary (String.t()).

  The result is an array of binary (Strings) entries that can be sent via UDP.
  """
  def prepare_message(message) do
    size = byte_size(message)
    cond do
      size > @max_message_size -> {:error, :message_too_long}
      size > @max_packet_size -> message |> split()
      true -> {:ok, [message]}
    end
  end

  @doc false
  defp split(message) do
    {messages, _count} = split(next_split(message), [])
    |> chunkify()
    {:ok, messages}
  end

  defp chunkify(messages) do
    packets = length(messages) |> :binary.encode_unsigned()
    id = :crypto.strong_rand_bytes(8)
    messages
    |> Enum.reduce(
      {[], 0},
      fn (payload, {encoded_messages, idx}) ->
        index = :binary.encode_unsigned(idx)
        encoded_message = <<0x1E, 0x0F, id::binary - size(8), index::binary - size(1), packets::binary-size(1), payload::binary>>
        {[encoded_message | encoded_messages], idx + 1}
      end
    )
  end

  def split({payload, message, length}, list) when length > @max_payload_size do
    split(next_split(message), [payload | list])
  end

  def split({payload, message, _length}, list) do
    [message | [payload | list]] |> Enum.reverse()
  end

  defp next_split(message) do
    <<payload::binary - size(@max_payload_size), rest::binary>> = message
    {payload, rest, String.length(rest)}
  end
end
