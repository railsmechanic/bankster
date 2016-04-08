defmodule Bankster.Mixfile do
  use Mix.Project

  def project do
    [app: :bankster,
     version: "0.2.0",
     elixir: "~> 1.2",
     description: description,
     package: package,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.11.4", only: [:dev]},
      {:earmark, ">= 0.0.0", only: [:dev]}
    ]
  end

  defp description do
    """
    Bankster is an IBAN and BIC validation tool for Elixir.
    """
  end

  defp package do
    [
      maintainers: ["Matthias Kalb"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/railsmechanic/bankster", "Docs" => "http://hexdocs.pm/bankster/0.1.0/"},
    ]
  end
end
