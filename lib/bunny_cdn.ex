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
      BunnyCDN.put(client, "./sample.mp3", "audio", "sample.mp3")
      {:ok, %{"HttpCode" => 201, "Message" => "File uploaded."}, %{status: 201}}
  """
  @doc since: "0.1.0"
  @spec put(Client.t(), Sting.t(), String.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def put(%Client{} = client, file, path, name)
      when is_binary(file) and is_binary(path) and is_binary(name) do
    uri = "#{path}/#{name}"

    with {:ok, body, %{status: 201} = resp} <-
           Request.request(client, :put, uri, file) do
      {:ok, body, resp}
    else
      {:ok, body, resp} -> {:error, body, resp}
      error -> error
    end
  end

  @doc """
  Put files into the storage zone at the root level.

  ## Examples
      client = Client.new("storage.bunnycdn.com", "my-sample-bunny-storage", "Sup3rsecretAPIkEy")
      BunnyCDN.put(client, "./sample.mp3", "audio/sample.mp3")
      {:ok, %{"HttpCode" => 201, "Message" => "File uploaded."}, %{status: 201}}
  """
  @doc since: "0.1.0"
  @spec put(Client.t(), Sting.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def put(%Client{} = client, file, uri) when is_binary(file) and is_binary(uri) do
    with {:ok, body, %{status: 201} = resp} <-
           Request.request(client, :put, uri, file) do
      {:ok, body, resp}
    else
      {:ok, body, resp} -> {:error, body, resp}
      error -> error
    end
  end

  @doc """
  List or get file from storage.

  ## Examples
      client = Client.new("storage.bunnycdn.com", "my-sample-bunny-storage", "Sup3rsecretAPIkEy")
      BunnyCDN.get(client, "foobar/")
      {:ok, [], %{status: 200}}

      BunnyCDN.get(client, "audio/")
      {:ok, [%{"Path" => "my-sample-bunny-storage/audio/"}], %{status: 200}}

      BunnyCDN.get("audio/unknown.mp3")
      {:error, %{"HttpCode" => 404, "Message" => "Object Not Found"}, %{status: 404}}
  """
  @doc since: "0.1.0"
  @spec get(Client.t(), String.t()) :: {:ok, term()} | {:error, Error.t()}
  def get(%Client{} = client, uri) when is_binary(uri) do
    with {:ok, %{status: 200} = resp} <-
           Request.request(client, :get, uri) do
      {:ok, resp}
    else
      {:ok, body, %{status: 500} = resp} -> {:error, body, resp}
      {:ok, body, %{status: 404} = resp} -> {:error, body, resp}
      error -> error
    end
  end

  @doc """
  Delete directory or file at path from storage.

  ## Examples
      client = Client.new("storage.bunnycdn.com", "my-sample-bunny-storage", "Sup3rsecretAPIkEy")
      BunnyCDN.delete(client, "test/")
      {:ok, %{"HttpCode" => 200, "Message" => "Directory deleted successfuly."}, %{status: 200}}

      BunnyCDN.delete(client, "sample.mp3")
      {:ok, %{"HttpCode" => 200, "Message" => "File deleted successfuly."}, %{status: 200}}

      BunnyCDN.delete(client, "audio/sample.mp3")
      {:ok, %{"HttpCode" => 200, "Message" => "File deleted successfuly."}, %{status: 200}}

      BunnyCDN.delete(client, "audio/unknown.mp3")
      {:error, %{status: 404}}
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
