# BunnyCDN

## Description
BunnyCDN is a simple HTTP client for the BunnyCDN Storage API. It uses Finch to make the requests.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `bunny_client` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:bunny_client, "~> 0.1.0"}
  ]
end
```

In your `config/config.exs` file, set the `storage_zone_region` and `storage_zone_name`.
Valid regions are:
 - Falkenstein, DE: "de"
 - London, UK: "uk"
 - New York, US: "ny"
 - Los Angeles, US: "la"
 - Singapore, SG: "sg"
 - Stockholm, SE: "se"
 - São Paulo, BR: "br"
 - Johannesburg, SA: "jh"

```elixir
config :bunny_client,
    storage_zone_region: "ny",
    storage_zone_name: "my-test-storage",
```

You can set the `storage_endpoint`, `storage_zone`, and `storage_api_key` as evironment variables as `BUNNY_DEFAULT_ENDPOINT`, `BUNNY_STORAGE_ZONE`, and `BUNNY_STORAGE_API_KEY` respectively.

For example, this is how you could set the key and run in iex.
`BUNNY_STORAGE_API_KEY=my-super-secret-api-key \
BUNNY_DEFAULT_ENDPOINT=ny.storage.bunnycdn.com \
BUNNY_STORAGE_ZONE=my-test-storage \
iex -S mix`

You can also setup the client manually via the `BunnyCDN.Client.create/3`.

## Examples

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bunny_client>.

