defmodule UdpClientBehaviour do
  @moduledoc """
  Primary interface definition for sending data using UDP
  """

  @type udp_port_number_t :: 0..65535
  @type destination_t :: %{ip_address: String.t(), port: udp_port_number_t}
  @type data_t :: binary | String.t()
  @callback send(data_t, destination_t) :: :ok | {:error, reason: any()}
end
