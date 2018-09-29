defmodule UdpClientEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :udp_client_ex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {UdpClientEx, []}
    ]
  end

  defp deps do
  end
end
