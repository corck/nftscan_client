defmodule NftscanClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :nftscan_client,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      name: "NFTScanClient",
      source_url: "https://github.com/corck/nftscan_client",
      homepage_url: "https://hex.pm/packages/nftscan_client",
      description: "A client for interacting with NFTScan API.",
      package: package(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:httpoison, "~> 1.8"}, {:jason, "~> 1.2"}]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Christoph Klocker"],
      contributors: [],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/corck/nftscan_client"}
    ]
  end
end
