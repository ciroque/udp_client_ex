defmodule UdpClientEx do
  @moduledoc """
  Documentation for UdpClientEx.
  """

  @behaviour UdpClientBehaviour

  def send(data, destination) do
    UdpClient.send(data, destination)
  end
end
