defmodule BunnyCDN.Request do
  @moduledoc """

  """

  alias BunnyCDN.Client

  @doc """
  """
  def request(%Client{} = client, method, uri, body \\ nil, headers \\ []) do
    url =
      client
      |> build_url(uri)

    headers =
      [
        access_key(client)
        | headers
      ]

    with {:ok, resp} <-
      Client.request(client, method, url, body, headers) do
      {:ok, body, resp}
    else
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
