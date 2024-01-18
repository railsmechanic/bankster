defmodule Bankster do
  @moduledoc """
  The main API for Bankster.
  """

  ## -- Functions
  @doc """
  Validates a given string whether it's a valid SWIFT BIC
  ## Example
      iex> Bankster.bic_valid?("INVALIDBIC")
      false
  """
  @spec bic_valid?(binary()) :: boolean()
  defdelegate bic_valid?(iban), to: Bankster.Bic, as: :valid?

  @doc """
  Validates a given string whether it's a valid IBAN
  ## Example
      iex> Bankster.iban_valid?("INVALIDIBAN")
      false
  """
  @spec iban_valid?(binary()) :: boolean()
  defdelegate iban_valid?(iban), to: Bankster.Iban, as: :valid?

  @doc """
  Validates a string whether it's a valid IBAN an returns an error tuple on invalid data.
  ## Example
      iex> Bankster.iban_validate("INVALIDIBAN")
      {:error, :invalid_country}

      iex> Bankster.iban_validate("DK838718234242342348644726815")
      {:error, :invalid_length}

      iex> Bankster.iban_validate("DK8387188644726815")
      {:ok, "DK8387188644726815"}
  """
  @spec iban_validate(binary()) :: {:ok, binary()} | {:error, atom()}
  defdelegate iban_validate(iban), to: Bankster.Iban, as: :validate
end
