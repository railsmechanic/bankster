defmodule Bankster.Iban do
  @moduledoc """
  Provides some IBAN related functions

  ## Examples
    iex> Bankster.Iban.valid?("INVALIDIBAN")
    false
  """

  @iban_rules %{
    "AL" => ~r/^[0-9]{8}[0-9A-Z]{16}$/,
    "AD" => ~r/^[0-9]{8}[0-9A-Z]{12}$/,
    "AT" => ~r/^[0-9]{16}$/,
    "BE" => ~r/^[0-9]{12}$/,
    "BA" => ~r/^[0-9]{16}$/,
    "BG" => ~r/^[A-Z]{4}[0-9]{6}[0-9A-Z]{8}$/,
    "HR" => ~r/^[0-9]{17}$/,
    "CY" => ~r/^[0-9]{8}[0-9A-Z]{16}$/,
    "CZ" => ~r/^[0-9]{20}$/,
    "DK" => ~r/^[0-9]{14}$/,
    "EE" => ~r/^[0-9]{16}$/,
    "FO" => ~r/^[0-9]{14}$/,
    "FI" => ~r/^[0-9]{14}$/,
    "FR" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "PF" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "TF" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "GP" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "MQ" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "YT" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "NC" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "RE" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "BL" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "MF" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "PM" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "WF" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "GE" => ~r/^[0-9A-Z]{2}[0-9]{16}$/,
    "DE" => ~r/^[0-9]{18}$/,
    "GI" => ~r/^[A-Z]{4}[0-9A-Z]{15}$/,
    "GR" => ~r/^[0-9]{7}[0-9A-Z]{16}$/,
    "GL" => ~r/^[0-9]{14}$/,
    "HU" => ~r/^[0-9]{24}$/,
    "IS" => ~r/^[0-9]{22}$/,
    "IE" => ~r/^[0-9A-Z]{4}[0-9]{14}$/,
    "IL" => ~r/^[0-9]{19}$/,
    "IT" => ~r/^[A-Z][0-9]{10}[0-9A-Z]{12}$/,
    "KZ" => ~r/^[0-9]{3}[0-9A-Z]{3}[0-9]{10}$/,
    "KW" => ~r/^[A-Z]{4}[0-9]{22}$/,
    "LV" => ~r/^[A-Z]{4}[0-9A-Z]{13}$/,
    "LB" => ~r/^[0-9]{4}[0-9A-Z]{20}$/,
    "LI" => ~r/^[0-9]{5}[0-9A-Z]{12}$/,
    "LT" => ~r/^[0-9]{16}$/,
    "LU" => ~r/^[0-9]{3}[0-9A-Z]{13}$/,
    "MK" => ~r/^[0-9]{3}[0-9A-Z]{10}[0-9]{2}$/,
    "MT" => ~r/^[A-Z]{4}[0-9]{5}[0-9A-Z]{18}$/,
    "MR" => ~r/^[0-9]{23}$/,
    "MU" => ~r/^[A-Z]{4}[0-9]{19}[A-Z]{3}$/,
    "MC" => ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/,
    "ME" => ~r/^[0-9]{18}$/,
    "NL" => ~r/^[A-Z]{4}[0-9]{10}$/,
    "NO" => ~r/^[0-9]{11}$/,
    "PL" => ~r/^[0-9]{24}$/,
    "PT" => ~r/^[0-9]{21}$/,
    "RO" => ~r/^[A-Z]{4}[0-9A-Z]{16}$/,
    "SM" => ~r/^[A-Z][0-9]{10}[0-9A-Z]{12}$/,
    "SA" => ~r/^[0-9]{2}[0-9A-Z]{18}$/,
    "RS" => ~r/^[0-9]{18}$/,
    "SK" => ~r/^[0-9]{20}$/,
    "SI" => ~r/^[0-9]{15}$/,
    "ES" => ~r/^[0-9]{20}$/,
    "SE" => ~r/^[0-9]{20}$/,
    "CH" => ~r/^[0-9]{5}[0-9A-Z]{12}$/,
    "TN" => ~r/^[0-9]{20}$/,
    "TR" => ~r/^[0-9]{5}[0-9A-Z]{17}$/,
    "AE" => ~r/^[0-9]{19}$/,
    "GB" => ~r/^[A-Z]{4}[0-9]{14}$/,
    "CI" => ~r/^[0-9A-Z]{2}[0-9]{22}$/
  }

  @replacements %{
    "A" => "10",
    "B" => "11",
    "C" => "12",
    "D" => "13",
    "E" => "14",
    "F" => "15",
    "G" => "16",
    "H" => "17",
    "I" => "18",
    "J" => "19",
    "K" => "20",
    "L" => "21",
    "M" => "22",
    "N" => "23",
    "O" => "24",
    "P" => "25",
    "Q" => "26",
    "R" => "27",
    "S" => "28",
    "T" => "29",
    "U" => "30",
    "V" => "31",
    "W" => "32",
    "X" => "33",
    "Y" => "34",
    "Z" => "35"
  }

  @doc """
  Validates a given string whether it's a valid IBAN
  """
  @spec valid?(binary) :: boolean
  def valid?(iban), do: is_valid?(iban)

  defp is_valid?(iban) when is_binary(iban) do
    iban = String.replace(iban, ~r/\s*/, "")
    cond do
      String.length(iban) < 15 ->
        false
      not_in_iban_rules?(iban) ->
        false
      no_iban_rules_match?(iban) ->
        false
      true ->
        iban_checksum_valid?(iban)
    end
  end
  defp is_valid?(_), do: false

  defp not_in_iban_rules?(iban) do
    !Map.has_key?(@iban_rules, String.slice(iban, 0..1))
  end

  defp no_iban_rules_match?(iban) do
    !Regex.match?(@iban_rules[String.slice(iban, 0..1)], String.slice(iban, 4..-1))
  end

  defp iban_checksum_valid?(iban) do
    (for <<c <- (String.slice(iban, 4..-1) <> String.slice(iban, 0, 4))>>, into: "", do: (@replacements[<<c>>] || <<c>>))
    |> String.to_integer
    |> rem(97) === 1
  end
end
