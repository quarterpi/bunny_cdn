defmodule BunnyCDN.MixProject do
  use Mix.Project

  def project do
    [
      app: :bunny_cdn,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      #      mod: {BunnyCND.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp description do
    """
    A simple Bunny CDN API client for Elixir.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Matthew Moody"],
      license: ["MIT"],
      links: %{"GitHub" => "https://github.com/quarterpi/bunny_cdn"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:req, "~> 0.3"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:bypass, "~> 2.1.0", only: :test}
    ]
  end
end
