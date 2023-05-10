defmodule BunnyCDN.HTTPClient.Req do
  @moduledoc """
  The default http client. It uses the [Req](https://hexdocs.pm/req/readme.html) package to make the http requests.
  """

  @behaviour BunnyCDN.HTTPClient

  @impl BunnyCDN.HTTPClient
  def request(method, url, body, headers, options) do
    req =
      Req.new(method: method, url: url, body: body, headers: headers)
      |> Req.Request.register_options(options)

    with {:ok, %{status: 200} = resp} <- Req.Request.run(req) do
      {:ok, resp}
    else
      {:ok, %{status: 500} = resp} -> {:error, resp}
      {:ok, %{status: 404} = resp} -> {:error, resp}
      error -> error
    end
  end
end
