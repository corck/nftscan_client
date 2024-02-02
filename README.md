# NftscanClient

Basic interface to the NFTScan API. Currently only requesting account data.
Work in prograss, not production ready. Feel free to contribute.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `nftscan_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:nftscan_client, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/nftscan_client>.

## Configuration

To use the client you need to set an environment variable `NFTSCAN_API_KEY`
or override the configuration like this

```elixir
config :nftscan_client, api_key: System.get_env("NFTSCAN_API_KEY")
```