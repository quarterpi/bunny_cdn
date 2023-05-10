defmodule BunnyCDN.Client do
  @moduledoc """
  Used for providing credentials and connection details for interacting with BunnyCDN Storage API.

  [BunnyCDN Storage Endpoints] https://docs.bunny.net/reference/storage-api

    - Falkenstein, DE: storage.bunnycdn.com
    - London, UK: uk.storage.bunnycdn.com
    - New York, US: ny.storage.bunnycdn.com
    - Los Angeles, US: la.storage.bunnycdn.com
    - Singapore, SG: sg.storage.bunnycdn.com
    - Stockholm, SE: se.storage.bunnycdn.com
    - São Paulo, BR: br.storage.bunnycdn.com
    - Johannesburg, SA: jh.storage.bunnycdn.com

  """
  @doc since: "v0.1.0"

  defstruct storage_endpoint: nil,
            storage_zone: nil,
            storage_api_key: nil,
            http_client: {BunnyCDN.HTTPClient.Req, []}

  @bunny_default_endpoint "BUNNY_DEFAULT_ENDPOINT"
  @bunny_storage_zone "BUNNY_STORAGE_ZONE"
  @bunny_storage_api_key "BUNNY_STORAGE_API_KEY"

  @type t :: %__MODULE__{
          storage_endpoint: binary() | nil,
          storage_zone: binary() | nil,
          storage_api_key: binary() | nil,
          http_client: {module(), keyword()}
        }

  def new!() do
    case System.get_env(@bunny_default_endpoint) do
      nil -> raise RuntimeError, "missing default endpoint"
      storage_endpoint -> new!(storage_endpoint)
    end
  end

  def new!(storage_endpoint) do
    case {System.get_env(@bunny_storage_zone), System.get_env(@bunny_storage_api_key)} do
      {nil, _} -> raise RuntimeError, "missing storage zone"
      {_, nil} -> raise RuntimeError, "missing api key"
      {storage_zone, storage_api_key} -> new(storage_endpoint, storage_zone, storage_api_key)
    end
  end

  def new(storage_endpoint, storage_zone, storage_api_key) do
    %BunnyCDN.Client{
      storage_endpoint: storage_endpoint,
      storage_zone: storage_zone,
      storage_api_key: storage_api_key
    }
  end

  def put_http_client(%__MODULE__{} = client, http_client) do
    %{client | http_client: http_client}
  end

  def request(client, method, url, body, headers) do
    {module, options} = Map.get(client, :http_client)
    apply(module, :request, [method, url, body, headers, options])
  end
end
