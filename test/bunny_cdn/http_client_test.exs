defmodule BunnyCDN.HTTPClientTest do
  use ExUnit.Case, async: true

  alias BunnyCDN.HTTPClient

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "req-based client" do
    test "request/5 with success response", %{bypass: bypass} do
      Bypass.expect_once(bypass, fn conn ->
        Plug.Conn.resp(conn, 200, "")
      end)

      result =
        HTTPClient.Req.request(
          :get,
          endpoint(bypass.port),
          "",
          [],
          _options = []
        )

      assert {:ok, %{status: 200, body: ""}} = result
    end
  end

  defp endpoint(port), do: "http://localhost:#{port}/"
end
