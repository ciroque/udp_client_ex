defmodule UdpClientEx do
  @moduledoc """
  Documentation for UdpClientEx.
  """

  use Application

  @behaviour UdpClientBehaviour

  def send(data, destination) do
    UdpClient.send(data, destination)
  end

  def start(_type, _args) do
    UdpClient.start_link()
  end
end
