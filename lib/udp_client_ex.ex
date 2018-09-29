defmodule UdpClientEx do
  @moduledoc """
  UdpClientEx.

  A simple client that can be used to send messages via UDP.

  """

  use Application

  @behaviour UdpClientBehaviour

  @doc """
  Sends a message to a destination.
  """
  def send(data, destination) do
    UdpClient.send(data, destination)
  end

  @doc false
  def start(_type, _args) do
    UdpClient.start_link()
  end
end
