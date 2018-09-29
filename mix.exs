defmodule UdpClientEx.MixProject do
  use Mix.Project

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

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/ciroque/udp_client_ex"},
      maintainers: ["Steve Wagner (scalawagz@outlook.com"]
    ]
  end

  def project do
    [
      app: :udp_client_ex,
      deps: deps(),
      description: "A simple library for sending messages via UDP.",
      elixir: "~> 1.6",
      name: "UDP Client Ex",
      package: package(),
      source_url: "https://github.com/ciroque/udp_client_ex",
      start_permanent: Mix.env() == :prod,
      version: "0.1.4",
    ]
  end
end
