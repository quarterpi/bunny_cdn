defmodule BunnyCDN.RequestTest do
  use ExUnit.Case, async: true

  alias BunnyCDN.Client
  alias BunnyCDN.Request
  alias BunnyCDN.HTTPClient.TestClient

  describe "request/5" do
    setup do
      client =
        Client.new("endpoint", "storage-zone", "super-secret-key")
        |> Map.put(:http_client, {TestClient, []})

      [client: client]
    end

    test "ensure access key present", %{client: client} do
      assert {:ok, _body, _http_response} = Request.request(client, :get, "audio/", "", [], [])

      assert_receive {:request, :get, url, body, headers, _options}

      header_names = Enum.map(headers, fn {key, _} -> key end)

      assert Enum.sort(header_names) == [
               "AccessKey"
             ]

      assert body == ""

      assert url == "https://endpoint/storage-zone/audio/"
    end
  end
end
