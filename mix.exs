defmodule Alchemy.Mixfile do
  use Mix.Project

  def project do
    [
      app: :alchemy,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:erlsom, "~> 1.4"},
      {:poison, "~> 3.0"},
      {:mix_test_watch, "~> 0.3", only: :test},
    ]
  end
end
