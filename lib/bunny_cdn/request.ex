defmodule BunnyCDN.Request do
  @moduledoc """
  Low level API for building requests. You usually won't need to use this. If you do need to use it, note that you will need to set the `Access_Key` headers yourself.
  """

  alias BunnyCDN.Client

  @doc """
  """
  @spec request(Client.t(), atom(), String.t(), binary() | nil, [], []) ::
          {:ok, binary(), term()} | {:error, term()}
  def request(%Client{} = client, method, uri, body \\ nil, headers \\ [], options \\ []) do
    url =
      client
      |> build_url(uri)

    headers = [
      access_key(client)
      | headers
    ]

    with {:ok, resp} <-
           Client.request(client, method, url, body, headers, options) do
      {:ok, resp.body, resp}
    else
      {:error, %{status: status, body: body} = resp} ->
        {:error, body, resp}

      error = {:error, _reason} ->
        error
    end
  end

  defp build_url(%Client{} = client, uri) do
    "https://#{client.storage_endpoint}/#{client.storage_zone}/#{uri}"
  end

  defp access_key(%Client{} = client) do
    {"AccessKey", client.storage_api_key}
  end
end
