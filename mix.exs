defmodule UdpClientEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :udp_client_ex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),

      name: "UDP Client Ex",
      source_url: "https://github.com/ciroque/udp_client_ex",
      docs: [
        main: "UDP Client Ex",
        extras: []
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {UdpClientEx, []}
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.0", only: :dev, runtime: false}
    ]
  end
end
