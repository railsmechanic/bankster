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
  @spec valid?(String.t()) :: boolean
  def valid?(bic), do: is_valid?(bic)

  defp is_valid?(bic) when is_binary(bic),
    do: Regex.match?(@bic_validation_regex, String.replace(bic, ~r/\s*/, ""))

  defp is_valid?(_), do: false

  @doc """
  Attempts to calculate the BIC given a valid IBAN. 
  """
  @spec calculate_bic_from_iban(String.t()) :: {:ok, String.t()} | {:error, Atom.t()}
  def calculate_bic_from_iban(iban) do
    case Bankster.Iban.validate(iban) do
      {:ok, canon_iban} -> 
        country = Bankster.Iban.country_code(canon_iban)
        bban = Bankster.Iban.bban(canon_iban)
        regexes = Bankster.Iban.iban_rules()
        matches = Regex.run(regexes[country][:rule], bban, [capture: :all_but_first])
        calculate_bic(country, matches)
      {:error, msg} -> 
        {:error, msg}
    end
  end

  # SPECIFIC BIC MAPPINGS
  
  @doc """
  Does the BIC calculation. Should be specified per-country. Done this way instead of a map
  to allow more dynamic calculation of the BIC for countries that need it.
  """
  @spec calculate_bic(String.t(), [String.t()]) :: {:ok, String.t()} | {:error, :unsupported_country | :unsupported_bank}
  defp calculate_bic("NL", matches) do
    mapping = %{
      "INGB" => "INGBNL2A XXX",
      "ABNA" => "ABNANL2A XXX",
      "RABO" => "RABONL2U XXX",
      "KNAB" => "KNABNL2H XXX",
      "BUNQ" => "BUNQNL2A XXX",
      "SNSB" => "SNSBNL2A XXX",
      "TRIO" => "TRIONL2U XXX",
      "ASNB" => "ASNBNL21 XXX",
      "RBRB" => "RBRBNL21 XXX"
    }
    basic_mapping(mapping, List.first(matches))
  end

  defp calculate_bic(_, _), do: {:error, :unsupported_country}

  # BIC MAPPING HELPERS

  @spec basic_mapping(%{required(String.t()) => String.t()}, String.t()) :: {:ok, String.t()} | {:error, :unsupported_bank}
  defp basic_mapping(mapping, bank) do
    if Map.has_key?(mapping, bank) do
      {:ok, mapping[bank]}
    else
      {:error, :unsupported_bank}
  end

  @spec basic_mapping_nested(%{required(String.t()) => %{required(String.t()) => String.t()}}, String.t(), String.t()) :: {:ok, String.t()} | {:error, :unsupported_bank}
  defp basic_mapping_nested(mapping, bank, branch) do
    if Map.has_key?(mapping, bank) and Map.has_key?(mapping[bank], branch) do
      {:ok, mapping[bank][branch]}
    else
      {:error, :unsupported_bank}
    end
  end
end