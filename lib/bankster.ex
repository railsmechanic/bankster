defmodule Bankster do
  @moduledoc """
  The main API for Bankster.
  """

  @doc """
  Validates a given string whether it's a valid SWIFT BIC
  ## Example
      iex> Bankster.bic_valid?("INVALIDBIC")
      false
  """
  @spec bic_valid?(String.t()) :: boolean
  defdelegate bic_valid?(iban), to: Bankster.Bic, as: :valid?

  @doc """
  Validates a given string whether it's a valid IBAN
  ## Example
      iex> Bankster.iban_valid?("INVALIDIBAN")
      false
  """
  @spec iban_valid?(String.t()) :: boolean
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
  @spec iban_validate(String.t()) :: {:ok, String.t()} | {:error, Atom.t()}
  defdelegate iban_validate(iban), to: Bankster.Iban, as: :validate

  @doc """
  Attempts to find the BIC associated with a valid IBAN. Returns an error tuple on invalid data.
  Does not support all countries nor all banks in supported countries. Patches are welcome..
  ## Example
      iex(1)> Bankster.bic_calculate("NL91ABNA0417164300")
      {:ok, "ABNANL2A XXX"}

      iex(2)> Bankster.bic_calculate("AL86751639367318444714198669")
      {:error, :unsupported_country}
  """
  @spec bic_calculate(String.t()) :: {:ok, String.t()} | {:error, Atom.t()}
  defdelegate bic_calculate(iban), to: Bankster.Bic, as: :calculate_bic_from_iban 
end
