# BunnyCDN

## Description
BunnyCDN is a simple batteries included HTTP client for the BunnyCDN Storage API. By default, it uses Req as the http client. You can supply your own by implementing the `BunnyCDN.HTTPClient` behaviour. See [https://github.com/quarterpi/bunny_cdn/blob/master/lib/http_client.ex](lib/http_client.ex) for more details.


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
Next, you will need to fetch your dependencies via `mix deps.get`.

Run with iex `iex -S mix`.

Optionally supply the storage endpoint, storage zone, and storage api key as environment variables:
```
BUNNY_STORAGE_API_KEY=my-super-secret-api-key \ 
BUNNY_DEFAULT_ENDPOINT=ny.storage.bunnycdn.com \ 
BUNNY_STORAGE_ZONE=my-test-storage \ 
iex -S mix
```

## Examples
If you load the storage endpoint, storage zone, and storage api keys as environment variables as demonstrated above, you can use the BunnyCDN.Client.new!/0 function to create a new client struct.
```
alias BunnyCDN.Client

client = Client.new!()

# List contents of root directory.
BunnyCDN.get(client, "/")

# List contents of files directory. If it does not exist, the contents of `body` will be []. 
BunnyCDN.get(client, "audio/")

# Download file at "audio/sample.mp3". If the file does not exists, an error touple will be returned with the status code 404. Otherwise the body will contain the binary representation of the file. The `content-type` and `content-length` headers can be used to determine the file's type and size.
BunnyCDN.get(client, "audio/sample.mp3")

# Upload a file. If the directory does not exists, it will be created. The status code will be 201 and the body will contain `%{"HttpCode" => 201, "Message" => "File uploaded."}`.
{:ok, file} = File.read("./sample.mp3")
uri = "audio/sample.mp3"
BunnyCDN.put(client, file, uri) 

# Optionally supply the file name and path separately.
BunnyCDN.put(client, file, "audio", "sample.mp3")

# Delete a file. The response will have the status code 200 and the body will contain {"HttpCode" => 200, "Message" => "File deleted successfuly."}
BunnyCDN.delete(client, "sample.mp3")

# Delete a directory. The response will have the status code 200 and the body will contain {"HttpCode" => 200, "Message" => "File deleted successfuly."}
BunnyCDN.delete(client, "files/")
```

## Acknowledgments
BunnyCDN is inspired by [aws-elixir](https://github.com/aws-beam/aws-elixir/tree/master).


Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/bunny_client>.

