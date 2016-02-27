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
  @spec bic_valid?(String.t) :: boolean
  defdelegate bic_valid?(iban), to: Bankster.Bic, as: :valid?

  @doc """
  Validates a given string whether it's a valid SWIFT BIC
  ## Example
      iex> Bankster.iban_valid?("INVALIDBIC")
      false
  """
  @spec iban_valid?(String.t) :: boolean
  defdelegate iban_valid?(iban), to: Bankster.Iban, as: :valid?
end
