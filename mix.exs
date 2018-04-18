defmodule Bankster.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bankster,
      version: "0.3.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Bankster",
      source_url: "https://github.com/railsmechanic/bankster"
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.18.3", only: [:dev]},
      {:earmark, "~> 1.2.5", only: [:dev]}
    ]
  end

  defp description do
    "Bankster is an IBAN and BIC validation tool for Elixir."
  end

  defp package do
    [
      maintainers: ["Matthias Kalb"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/railsmechanic/bankster"}
    ]
  end
end
