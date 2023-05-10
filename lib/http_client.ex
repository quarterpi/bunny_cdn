defmodule BunnyCDN.HTTPClient do
  @moduledoc """
  Http Client Behaviour specification.

  The default http client uses Req underneath the hood. You can implement your own http client
  if your prefer a different http client. You'll need to set the `:http_client` configuration in `BunnyCDN.Client`:

      client = %BunnyCDN.Client{http_client: {MyHTTPClient, []}}
      BunnyCDN.get(client, "some/file.txt")
  """

  @doc """
  Executes an HTTP request. Must return either {:ok, map} or {:error, reason}.

  - `body` must be raw file data without any encoding. See [BunnyCDN API reference]https://docs.bunny.net/reference/put_-storagezonename-path-filename
  - `headers` already contains required headers such as the Authorization headers.
  """
  @callback request(
    method :: :get | :post | :head | :patch | :delete | :options | :put | String.t(),
    url :: String.t() | URI.t(),
    body :: iodata() | nil,
    headers :: [{header_name :: String.t(), header_value :: String.t()}] | [] | nil,
    options :: keyword()
  ) ::
  {:ok, binary(), term()}
  | {:error, term()}

end
