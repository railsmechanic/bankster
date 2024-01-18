defmodule Bankster.Bic do
  @moduledoc """
  Module provides some SWIFT BIC related functions.
  """

  ## -- Module attributes
  @bic_validation_regex ~r/^([a-zA-Z]){4}([a-zA-Z]){2}([0-9a-zA-Z]){2}([0-9a-zA-Z]{3})?$/

  ## -- Functions
  @doc """
  Validates a given string whether it's a valid SWIFT BIC

  ## Examples
    iex> Bankster.Bic.valid?("INVALIDBIC")
    false
  """
  @spec valid?(binary()) :: boolean()
  def valid?(bic) when is_binary(bic),
    do: Regex.match?(@bic_validation_regex, String.replace(bic, ~r/\s*/, ""))

  def valid?(_),
    do: false
end
