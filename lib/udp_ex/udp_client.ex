defmodule UdpClient do
  @moduledoc false

  use GenServer

  @behaviour UdpClientBehaviour

  require Logger

  @udp_port 0

  ## Public API

  def send(data, destination) do
    GenServer.cast(:udp_client_ex_server, {:send, data, destination})
  end

  ## GenServer

  def init(state) do
    {:ok, socket} = :gen_udp.open(@udp_port)
    {:ok, state |> Map.put(:socket, socket)}
  end

  def start_link() do
    GenServer.start(__MODULE__, %{}, name: :udp_client_ex_server)
  end

  ## Implementation

  def handle_cast({:send, data, %{ip_address: _, port: _} = destination}, %{socket: socket} = state) do
    Logger.debug("handle_cast :send, data: #{inspect(data)}, destination: #{inspect(destination)}, state: #{inspect(state)}")

    case data |> Datagram.prepare_message() do
      {:ok, messages} ->
        messages |> send_message(destination |> Map.put(:socket, socket))
      {:error, :message_too_long} ->
        Logger.error("Message is too long: #{data}")
    end

    {:noreply, state}
  end

  defp send_message([], %{socket: _socket, ip_address: _ip_address, port: _port}) do
    Logger.warn("empty list...")
  end

  defp send_message([datagram], %{socket: socket, ip_address: ip_address, port: port}) do
    host = ip_address |> to_charlist()
    :gen_udp.send(socket, host, port, datagram)
  end

  defp send_message([_|_] = datagrams, %{socket: _socket, ip_address: _ip_address, port: _port} = destination) do
    datagrams
    |> Enum.map(fn datagram -> send_message([datagram], destination) end)
  end
end
