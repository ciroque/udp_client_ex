defmodule UdpClientBehaviour do
  @moduledoc """
  Primary interface definition for sending data using UDP
  """

  @typedoc "Represents a valid UDP port number."
  @type udp_port_number_t :: 0..65535

  @typedoc "Represents the combination of an IP Address and port number."
  @type destination_t :: %{ip_address: String.t(), port: udp_port_number_t}

  @typedoc "Represents the data that can be send via UDP."
  @type data_t :: binary | String.t()

  @doc """
  Defines the method that allows data to be sent via UDP.
  """
  @callback send(data_t, destination_t) :: :ok | {:error, reason: any()}
end
