# Bankster [![Build Status](https://travis-ci.org/railsmechanic/bankster.svg?branch=master)](https://travis-ci.org/railsmechanic/bankster)

An easy to use Elixir validator for IBAN account and BIC numbers. It includes IBAN rules for 115 countries and validation for BIC numbers. 

- IBAN validation is done using format, country, length and checksum.  
- BIC validation is done using format.

## Installation

The package can be installed as Hex package:

  1. Add bankster to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:bankster, "~> 0.3.3"}]
  end
  ```

  2. Run `mix deps.get` to fetch the package from hex


## Usage

### Validate IBANs
You can either use `Bankster.iban_valid?/1` or `Bankster.Iban.valid?/1` to validate IBANs.

```elixir
iex> Bankster.iban_valid?("NOTVALID")
false

iex> Bankster.Iban.valid?("NOTVALID")
false
```

### Validation with errors
Beside the boolean validation function, Bankster offers a validation function which returns the corresponding error.
Like the other validation, you can use `Bankster.iban_validate/1` or `Bankster.Iban.validate/1` to validate IBANs.

```elixir
iex> Bankster.iban_validate("NOTVALID")
{:error, :invalid_country}

iex> Bankster.Iban.validate("DK8387188644726815223423423423423423423")
{:error, :invalid_length}

iex> Bankster.Iban.validate("DK83 8718 8644 7268 15")
{:ok, "DK8387188644726815"}
```

### Validate BICs
Validating BICs works the same way as already shown for IBANs.
So you can either use `Bankster.bic_valid?/1` or `Bankster.Bic.valid?/1` to validate BICs.

```elixir
iex> Bankster.bic_valid?("NOTVALID")
false

iex> Bankster.Bic.valid?("NOTVALID")
false
```

## License
Bankster source code is released under MIT License. Check LICENSE file for more information.
