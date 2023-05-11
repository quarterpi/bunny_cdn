defmodule BunnyCDN.ClientTest do
  use ExUnit.Case, async: true

  setup do
    %{client: %BunnyCDN.Client{}}
  end

  describe "request/5" do
    setup do
      bypass = Bypass.open()
      {:ok, bypass: bypass}
    end

    test "sends a HEAD request", %{client: client, bypass: bypass} do
      headers = [
        {"accesskey", "give_me_access_123"}
      ]

      Bypass.expect_once(bypass, "HEAD", "", fn conn ->
        assert true == Enum.all?(headers, fn header -> Enum.member?(conn.req_headers, header) end)
        Plug.Conn.resp(conn, 200, "")
      end)

      result = BunnyCDN.Client.request(client, :head, endpoint(bypass.port), "", headers, [])
      assert {:ok, %{status: 200, body: ""}} = result
    end
  end

  defp endpoint(port), do: "http://localhost:#{port}/"
end
