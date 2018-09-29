# UDP Client Ex

Simple UDP client for Elixir.

[![CircleCI](https://circleci.com/gh/ciroque/udp_client_ex.svg?style=svg)](https://circleci.com/gh/ciroque/udp_client_ex)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `udp_client_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:udp_client_ex, "~> 0.1.0"}
  ]
end
```

You also need to add :udp_client_ex to your applications to ensure proper initialization:

```elixir
def application do
  [applications: [:udp_client_ex]]
end
```

Eventually the library will be available on Hex and the documents found [here](https://hexdocs.pm/udp_client_ex).

