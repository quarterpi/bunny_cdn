defmodule BunnyCDN.HTTPClient.Req do
  @mdouledoc """
  """

  @behaviour BunnyCDN.HTTPClient

  @impl BunnyCDN.HTTPClient
  def request(method, url, body, headers, options) do
    req = Req.new(method: method, url: url, body: body, headers: headers)
          |> Req.Request.register_options(options)
    with {:ok, %{status: 200} = resp} <- Req.Request.run(req)
            do
      {:ok, resp}
    else
      {:ok, %{status: 500} = resp} -> {:error, resp}
      {:ok, %{status: 404} = resp} -> {:error, resp}
      error -> error
    end
  end
end

