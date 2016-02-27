defmodule Bankster.Bic do
  @moduledoc """
  Provides some SWIFT BIC related functions.
  """

  @bic_validation_regex ~r/^([a-zA-Z]){4}([a-zA-Z]){2}([0-9a-zA-Z]){2}([0-9a-zA-Z]{3})?$/

  @doc """
  Validates a given string whether it's a valid SWIFT BIC
  ## Example
      iex> Bankster.Bic.valid?("INVALIDBIC")
      false
  """
  @spec valid?(binary) :: boolean
  def valid?(bic), do: is_valid?(bic)

  defp is_valid?(bic) when is_binary(bic) do
    Regex.match?(@bic_validation_regex, String.replace(bic, ~r/\s*/, ""))
  end
  defp is_valid?(_), do: false
end
