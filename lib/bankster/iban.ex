defmodule Bankster.Iban do
  @moduledoc """
  Provides some IBAN related functions.
  """

  @iban_rules %{
    "AA" => %{length: 16, rule: ~r/^[0-9A-Z]{12}$/i},
    "AD" => %{length: 24, rule: ~r/^[0-9]{8}[0-9A-Z]{12}$/i},
    "AE" => %{length: 23, rule: ~r/^[0-9]{19}$/i},
    "AL" => %{length: 28, rule: ~r/^[0-9]{8}[0-9A-Z]{16}$/i},
    "AO" => %{length: 25, rule: ~r/^[0-9]{21}$/i},
    "AT" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "AX" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "AZ" => %{length: 28, rule: ~r/^[A-Z]{4}[0-9A-Z]{20}$/i},
    "BA" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "BE" => %{length: 16, rule: ~r/^[0-9]{12}$/i},
    "BF" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "BG" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{6}[0-9A-Z]{8}$/i},
    "BH" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{14}$/i},
    "BI" => %{length: 16, rule: ~r/^[0-9]{12}$/i},
    "BJ" => %{length: 28, rule: ~r/^[A-Z]{1}[0-9]{23}$/i},
    "BL" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "BR" => %{length: 29, rule: ~r/^[0-9]{23}[A-Z]{1}[0-9A-Z]{1}$/i},
    "BY" => %{length: 28, rule: ~r/^[0-9A-Z]{4}[0-9]{4}[0-9A-Z]{16}$/i},
    "CF" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "CG" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "CH" => %{length: 21, rule: ~r/^[0-9]{5}[0-9A-Z]{12}$/i},
    "CI" => %{length: 28, rule: ~r/^[A-Z]{1}[0-9]{23}$/i},
    "CM" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "CR" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "CV" => %{length: 25, rule: ~r/^[0-9]{21}$/i},
    "CY" => %{length: 28, rule: ~r/^[0-9]{8}[0-9A-Z]{16}$/i},
    "CZ" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "DE" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "DJ" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "DK" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "DO" => %{length: 28, rule: ~r/^[0-9A-Z]{4}[0-9]{20}$/i},
    "DZ" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "EE" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "EG" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "ES" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "FI" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "FO" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "FR" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "GA" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "GB" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{14}$/i},
    "GE" => %{length: 22, rule: ~r/^[A-Z]{2}[0-9]{16}$/i},
    "GF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "GI" => %{length: 23, rule: ~r/^[A-Z]{4}[0-9A-Z]{15}$/i},
    "GL" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "GP" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "GQ" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "GR" => %{length: 27, rule: ~r/^[0-9]{7}[0-9A-Z]{16}$/i},
    "GT" => %{length: 28, rule: ~r/^[0-9A-Z]{24}$/i},
    "GW" => %{length: 25, rule: ~r/^[0-9A-Z]{2}[0-9]{19}$/i},
    "HN" => %{length: 28, rule: ~r/^[A-Z]{4}[0-9]{20}$/i},
    "HR" => %{length: 21, rule: ~r/^[0-9]{17}$/i},
    "HU" => %{length: 28, rule: ~r/^[0-9]{24}$/i},
    "IE" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{14}$/i},
    "IL" => %{length: 23, rule: ~r/^[0-9]{19}$/i},
    "IQ" => %{length: 23, rule: ~r/^[0-9A-Z]{4}[0-9]{15}$/i},
    "IR" => %{length: 26, rule: ~r/^[0-9]{22}$/i},
    "IS" => %{length: 26, rule: ~r/^[0-9]{22}$/i},
    "IT" => %{length: 27, rule: ~r/^[A-Z]{1}[0-9]{10}[0-9A-Z]{12}$/i},
    "JO" => %{length: 30, rule: ~r/^[A-Z]{4}[0-9]{4}[0-9A-Z]{18}$/i},
    "KM" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "KW" => %{length: 30, rule: ~r/^[A-Z]{4}[0-9]{22}$/i},
    "KZ" => %{length: 20, rule: ~r/^[0-9]{3}[0-9A-Z]{13}$/i},
    "LB" => %{length: 28, rule: ~r/^[0-9]{4}[0-9A-Z]{20}$/i},
    "LC" => %{length: 32, rule: ~r/^[A-Z]{4}[0-9A-Z]{24}$/i},
    "LI" => %{length: 21, rule: ~r/^[0-9]{5}[0-9A-Z]{12}$/i},
    "LT" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "LU" => %{length: 20, rule: ~r/^[0-9]{3}[0-9A-Z]{13}$/i},
    "LV" => %{length: 21, rule: ~r/^[A-Z]{4}[0-9A-Z]{13}$/i},
    "MA" => %{length: 28, rule: ~r/^[0-9]{24}$/i},
    "MC" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "MD" => %{length: 24, rule: ~r/^[0-9A-Z]{20}$/i},
    "ME" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "MF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "MG" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "MK" => %{length: 19, rule: ~r/^[0-9]{3}[0-9A-Z]{10}[0-9]{2}$/i},
    "ML" => %{length: 28, rule: ~r/^[A-Z]{1}[0-9]{23}$/i},
    "MQ" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "MR" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "MT" => %{length: 31, rule: ~r/^[A-Z]{4}[0-9]{5}[0-9A-Z]{18}$/i},
    "MU" => %{length: 30, rule: ~r/^[A-Z]{4}[0-9]{19}[A-Z]{3}$/i},
    "MZ" => %{length: 25, rule: ~r/^[0-9]{21}$/i},
    "NC" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "NE" => %{length: 28, rule: ~r/^[A-Z]{2}[0-9]{22}$/i},
    "NI" => %{length: 32, rule: ~r/^[A-Z]{4}[0-9]{24}$/i},
    "NL" => %{length: 18, rule: ~r/^[A-Z]{4}[0-9]{10}$/i},
    "NO" => %{length: 15, rule: ~r/^[0-9]{11}$/i},
    "PF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "PK" => %{length: 24, rule: ~r/^[A-Z]{4}[0-9A-Z]{16}$/i},
    "PL" => %{length: 28, rule: ~r/^[0-9]{24}$/i},
    "PM" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "PS" => %{length: 29, rule: ~r/^[A-Z]{4}[0-9A-Z]{21}$/i},
    "PT" => %{length: 25, rule: ~r/^[0-9]{21}$/i},
    "QA" => %{length: 29, rule: ~r/^[A-Z]{4}[0-9]{4}[0-9A-Z]{17}$/i},
    "RE" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "RO" => %{length: 24, rule: ~r/^[A-Z]{4}[0-9A-Z]{16}$/i},
    "RS" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "SA" => %{length: 24, rule: ~r/^[0-9]{2}[0-9A-Z]{18}$/i},
    "SC" => %{length: 31, rule: ~r/^[A-Z]{4}[0-9]{20}[A-Z]{3}$/i},
    "SE" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "SI" => %{length: 19, rule: ~r/^[0-9]{15}$/i},
    "SK" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "SM" => %{length: 27, rule: ~r/^[A-Z]{1}[0-9]{10}[0-9A-Z]{12}$/i},
    "SN" => %{length: 28, rule: ~r/^[A-Z]{1}[0-9]{23}$/i},
    "ST" => %{length: 25, rule: ~r/^[0-9]{8}[0-9]{13}$/i},
    "SV" => %{length: 28, rule: ~r/^[0-9A-Z]{4}[0-9]{20}$/i},
    "TD" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "TF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "TG" => %{length: 28, rule: ~r/^[A-Z]{2}[0-9]{22}$/i},
    "TL" => %{length: 23, rule: ~r/^[0-9]{19}$/i},
    "TN" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "TR" => %{length: 26, rule: ~r/^[0-9]{6}[0-9A-Z]{16}$/i},
    "UA" => %{length: 29, rule: ~r/^[0-9]{6}[0-9A-Z]{19}$/i},
    "VG" => %{length: 24, rule: ~r/^[A-Z]{4}[0-9]{16}$/i},
    "WF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "XK" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "YT" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i}
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
  Formats and returns a given IBAN in compact format.

  ## Examples
      iex> Bankster.Iban.format_compact("DK8     38 7188 64472     6815   ")
      "DK8387188644726815"
  """
  @spec format_compact(String.t()) :: String.t()
  def format_compact(iban), do: format_default(iban)

  @doc """
  Formats and returns a given IBAN in pretty format.

  ## Examples
      iex> Bankster.Iban.format_pretty("DK8387188644726815")
      "DK838 7188 64472 6815"
  """
  @spec format_pretty(String.t()) :: String.t()
  def format_pretty(iban) do
    ~r/.{1,4}/
    |> Regex.scan(format_default(iban))
    |> List.flatten()
    |> Enum.join(" ")
  end

  @doc """
  Returns the country code of the given IBAN.

  ## Examples
      iex> Bankster.Iban.country_code("DK8387188644726815")
      "DK"
  """
  @spec country_code(String.t()) :: String.t()
  def country_code(iban) do
    iban
    |> format_default()
    |> String.slice(0..1)
  end

  @doc """
  Returns the checksum of the given IBAN.

  ## Examples
      iex> Bankster.Iban.checksum("DK8387188644726815")
      83
  """
  @spec checksum(String.t()) :: String.t()
  def checksum(iban) do
    iban
    |> format_default()
    |> String.slice(2..3)
  end

  @doc """
  Returns the country codes of the supported countries.

  ## Examples
      iex> Bankster.Iban.supported_countries()
      ["SM", "KZ", "SN", "BA", "GA", "KW", "MU", ...]
  """
  @spec supported_countries() :: list(String.t())
  def supported_countries, do: Map.keys(@iban_rules)

  @doc """
  Validates whether the given country code is within the supported countries.

  ## Examples
      iex> Bankster.Iban.supported_country?("DE")
      true

      iex> Bankster.Iban.supported_country?("XYZ")
      false
  """
  @spec supported_country?(String.t()) :: boolean
  def supported_country?(country_code)

  def supported_country?(country_code) when is_binary(country_code),
    do: Map.has_key?(@iban_rules, format_default(country_code))

  def supported_country?(_invalid), do: false

  @doc """
  Returns the BBAN of the given IBAN.

  ## Examples
      iex> Bankster.Iban.bban("DK8387188644726815")
      "87188644726815"
  """
  @spec bban(String.t()) :: String.t()
  def bban(iban) do
    iban
    |> format_default()
    |> String.slice(4..-1)
  end

  @doc """
  Returns the size/length of the given IBAN.

  ## Examples
      iex> Bankster.Iban.size("DK 8387   188644     726815")
      18
  """
  @spec size(String.t()) :: Integer.t()
  def size(iban) do
    iban
    |> format_default()
    |> String.length()
  end

  @doc """
  Validates a string whether it's a valid IBAN an returns an error tuple on invalid data.

  ## Examples
      iex> Bankster.Iban.validate("INVALIDIBAN")
      {:error, :invalid_country}

      iex> Bankster.Iban.validate("DK838718234242342348644726815")
      {:error, :invalid_length}

      iex> Bankster.Iban.validate("DK8387188644726815")
      {:ok, "DK8387188644726815"}
  """
  @spec validate(String.t()) :: {:ok, String.t()} | {:error, Atom.t()}
  def validate(iban) do
    cond do
      iban_violates_format?(iban) ->
        {:error, :invalid_format}

      iban_violates_country?(iban) ->
        {:error, :invalid_country}

      iban_violates_length?(iban) ->
        {:error, :invalid_length}

      iban_violates_country_rule?(iban) ->
        {:error, :invalid_format}

      iban_violates_checksum?(iban) ->
        {:error, :invalid_checksum}

      true ->
        {:ok, format_compact(iban)}
    end
  end

  @doc """
  Validates a string whether it's a valid IBAN and returns a boolen value.

  ## Examples
      iex> Bankster.Iban.valid?("INVALIDIBAN")
      false

      iex> Bankster.Iban.valid?("DK8387188644726815")
      true
  """
  @spec valid?(String.t()) :: boolean
  def valid?(iban), do: match?({:ok, _}, validate(iban))

  ##################################################
  ## HELPERS

  @spec format_default(String.t()) :: String.t()
  defp format_default(iban) do
    iban
    |> to_string()
    |> String.replace(~r/\s*/i, "")
    |> String.upcase()
  end

  @spec iban_violates_format?(String.t()) :: boolean
  defp iban_violates_format?(iban), do: Regex.match?(~r/[^A-Z0-9]/i, format_default(iban))

  @spec iban_violates_country?(String.t()) :: boolean
  defp iban_violates_country?(iban), do: !Map.has_key?(@iban_rules, country_code(iban))

  @spec iban_violates_length?(String.t()) :: boolean
  defp iban_violates_length?(iban),
    do: size(iban) != get_in(@iban_rules, [country_code(iban), :length])

  @spec iban_violates_country_rule?(String.t()) :: boolean
  defp iban_violates_country_rule?(iban) do
    if iban_rule = get_in(@iban_rules, [country_code(iban), :rule]) do
      !Regex.match?(iban_rule, String.slice(format_default(iban), 4..-1))
    else
      false
    end
  end

  @spec iban_violates_checksum?(String.t()) :: boolean
  defp iban_violates_checksum?(iban) do
    remainder =
      for(<<c <- bban(iban) <> country_code(iban) <> "00">>, into: "", do: @replacements[<<c>>] || <<c>>)
      |> String.to_integer()
      |> rem(97)

    calculated_checksum =
      (98 - remainder)
      |> Integer.to_string()
      |> String.pad_leading(2, "0")

    calculated_checksum !== checksum(iban)
  end
end
