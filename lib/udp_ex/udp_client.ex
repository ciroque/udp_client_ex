defmodule UdpClient do
  @moduledoc false

  use GenServer

  @behaviour UdpClientBehaviour

  require Logger

  @udp_port 0

  ## Public API

  def send(data, destination) do
    GenServer.cast(:udp_ex_server, {:send, data, destination})
  end

  ## GenServer

  def init(state) do
    {:ok, socket} = :gen_udp.open(@udp_port)
    {:ok, state |> Map.put(:socket, socket)}
  end

  def start_link() do
    GenServer.start(__MODULE__, %{}, name: :udp_ex_server)
  end

  ## Implementation

  def handle_cast({:send, data, %{ip_address: ip_address, port: port} = destination}, %{socket: socket} = state) do
    Logger.debug("handle_cast :send, data: #{inspect(data)}, destination: #{inspect(destination)}, state: #{inspect(state)}")
    host = ip_address |> to_charlist()
    :gen_udp.send(socket, host, port, data)

    {:noreply, state}
  end
end
