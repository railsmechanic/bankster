# Bankster

Bankster is an IBAN and BIC validation tool for Elixir.

## Installation

The package can be installed as Hex package:

  1. Add bankster to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:bankster, "~> 0.2.1"}]
  end
  ```

  2. Run `mix deps.get` to fetch the package from hex


## Usage

### Validate IBANs
You can either use `Bankster.iban_valid?("YOURIBAN")` or `Bankster.Iban.valid?("YOURIBAN")` to validate IBANs.

```elixir
iex> Bankster.iban_valid?("NOTVALID")
false

iex> Bankster.Iban.valid?("NOTVALID")
false
```

### Validate BICs
Validating BICs works the same way as already shown for IBANs.
So you can either use `Bankster.bic_valid?("YOURBIC")` or `Bankster.Bic.valid?("YOURBIC")` to validate BICs.

```elixir
iex> Bankster.bic_valid?("NOTVALID")
false

iex> Bankster.Bic.valid?("NOTVALID")
false
```

## License
Bankster source code is released under MIT License. Check LICENSE file for more information.
