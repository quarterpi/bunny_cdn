defmodule BunnyCDN do
  @moduledoc """
  A simple HTTP Client for the Bunny Storage API.
  """

  @moduledoc since: "0.1.0"

  alias BunnyCDN.Client
  alias BunnyCDN.Request

  @doc """
  Put files into the storage zone at the defined path.

  ## Examples
      client = Client.new("storage.bunnycdn.com", "my-sample-bunny-storage", "Sup3rsecretAPIkEy")
      BunnyCDN.put("./sample.mp3", "audio", "sample.mp3")
      {:ok, %Finch.Response{status: 201}}

      iex> BunnyCDN.put("./unavailable.mp4", "video", "unavailable.mp4")
      {:error, :file_not_found}
  """
  @doc since: "0.1.0"
  @spec put(Client.t(), Sting.t(), String.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def put(%Client{} = client, file, path, name) when is_binary(file) and is_binary(path) and is_binary(name) do
    uri = "#{path}/#{name}"
    with {:ok, %{status: 201} = resp} <-
      Request.request(client, :put, uri, file) do
      {:ok, resp}
    else
      {:ok, %{status: 400} = resp} -> {:error, resp}
      error -> error
    end
  end

  @doc """
  Put files into the storage zone at the root level.

  ## Examples
      BunnyCDN.put("./sample.mp3", "sample.mp3")
      {:ok, %Finch.Response{status: 201}}

      iex> BunnyCDN.put("./unavailable.mp4", "unavailable.mp4")
      {:error, :file_not_found}
  """
  @doc since: "0.1.0"
  @spec put(Client.t(), Sting.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def put(%Client{} = client, file, uri) when is_binary(file) and is_binary(uri) do
    with {:ok, %{status: 201} = resp} <-
      Request.request(client, :put, uri, file) do
      {:ok, resp}
    else
      {:error, :enoent} -> {:error, :file_not_found}
      {:ok, %{status: 400} = resp} -> {:error, resp}
      error -> error
    end
  end

  @doc """
  Get file from storage.

  ## Examples
      BunnyCDN.get("audio/sample.mp3")
      {:ok, %Finch.Response{status: 200}}

      BunnyCDN.get("audio/unknown.mp3")
      {:error, %Finch.Response{status: 404}}
  """
  @doc since: "0.1.0"
  @spec get(Client.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def get(%Client{} = client, uri) when is_binary(uri) do
    with {:ok, %{status: 200} = resp} <-
      Request.request(client, :get, uri) do
      {:ok, resp}
    else
      {:ok, %{status: 500} = resp} -> {:error, resp}
      {:ok, %{status: 404} = resp} -> {:error, resp}
      error -> error
    end
  end

  @doc """
  Delete file at path from storage.

  ## Examples
      BunnyCDN.get("sample.mp3")
      {:ok, %Finch.Response{status: 200}}

      BunnyCDN.get("audio/sample.mp3")
      {:ok, %Finch.Response{status: 200}}

      BunnyCDN.get("audio/unknown.mp3")
      {:error, %Finch.Response{status: 404}}
  """
  @doc since: "0.1.0"
  @spec delete(Client.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def delete(%Client{} = client, uri) when is_binary(uri) do
    with {:ok, %{status: 200} = resp} <-
      Request.request(client, :delete, uri) do
      {:ok, resp}
    else
      {:ok, %{status: 500} = resp} -> {:error, resp}
      {:ok, %{status: 404} = resp} -> {:error, resp}
      error -> error
    end
  end

end
