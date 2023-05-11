defmodule BunnyCDNTest do
  use ExUnit.Case

  doctest BunnyCDN

  alias BunnyCDN.Client
  alias BunnyCDN.HTTPClient.TestClient

  describe "put/3" do
    setup do
      client =
        Client.new("endpoint", "storage-zone", "super-secret-key")
        |> Map.put(:http_client, {TestClient, []})

      [client: client]
    end

    test "put file at expected endpoint", %{client: client} do
      assert {:ok, "", _http_response} = BunnyCDN.put(client, <<002_244>>, "audio", "sample.mp3")

      assert_receive {:request, :put, url, body, _headers, _options}

      assert body == <<002_244>>

      assert url == "https://endpoint/storage-zone/audio/sample.mp3"
    end
  end

  describe "put/2" do
    setup do
      client =
        Client.new("endpoint", "storage-zone", "super-secret-key")
        |> Map.put(:http_client, {TestClient, []})

      [client: client]
    end

    test "put file at expected endpoint", %{client: client} do
      assert {:ok, "", _http_response} = BunnyCDN.put(client, <<002_244>>, "audio/sample.mp3")

      assert_receive {:request, :put, url, body, _headers, _options}

      assert body == <<002_244>>

      assert url == "https://endpoint/storage-zone/audio/sample.mp3"
    end
  end

  describe "get/2" do
    setup do
      client =
        Client.new("endpoint", "storage-zone", "super-secret-key")
        |> Map.put(:http_client, {TestClient, []})

      [client: client]
    end

    test "", %{client: client} do
      assert {:ok, "", _http_response} = BunnyCDN.get(client, "audio/")

      assert_receive {:request, :get, url, body, _headers, _options}

      assert body == nil

      assert url == "https://endpoint/storage-zone/audio/"
    end
  end

  describe "delete/2" do
    setup do
      client =
        Client.new("endpoint", "storage-zone", "super-secret-key")
        |> Map.put(:http_client, {TestClient, []})

      [client: client]
    end

    test "delete a directory", %{client: client} do
      assert {:ok, "", _http_response} = BunnyCDN.delete(client, "audio/")

      assert_receive {:request, :delete, url, body, _headers, _options}

      assert body == nil

      assert url == "https://endpoint/storage-zone/audio/"
    end

    test "delete a file", %{client: client} do
      assert {:ok, "", _http_response} = BunnyCDN.delete(client, "audio/sample.mp3")

      assert_receive {:request, :delete, url, body, _headers, _options}

      assert body == nil

      assert url == "https://endpoint/storage-zone/audio/sample.mp3"
    end
  end
end
