defmodule BunnyCDN.HTTPClient.TestClient do
  @behaviour BunnyCDN.HTTPClient

  @impl true
  def request(method, url, body, headers, options) do
    send(self(), {:request, method, url, body, headers, options})

    if method == :put do
      {status, _opts} = Keyword.pop(options, :return_status, 201)

      {:ok, %{status: status, headers: [], body: ""}}
    else
      {status, _opts} = Keyword.pop(options, :return_status, 200)

      {:ok, %{status: status, headers: [], body: ""}}
    end
  end
end
