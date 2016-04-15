defmodule Bankster.Iban do
  @moduledoc """
  Provides some IBAN related functions.
  """

  @iban_rules %{
    "AL" => %{length: 28, rule: ~r/^[0-9]{8}[0-9A-Z]{16}$/i},
    "AD" => %{length: 24, rule: ~r/^[0-9]{8}[0-9A-Z]{12}$/i},
    "AT" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "BE" => %{length: 16, rule: ~r/^[0-9]{12}$/i},
    "BA" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "BG" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{6}[0-9A-Z]{8}$/i},
    "HR" => %{length: 21, rule: ~r/^[0-9]{17}$/i},
    "CY" => %{length: 28, rule: ~r/^[0-9]{8}[0-9A-Z]{16}$/i},
    "CZ" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "DK" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "EE" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "FO" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "FI" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "FR" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "PF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "TF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "GP" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "MQ" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "YT" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "NC" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "RE" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "BL" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "MF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "PM" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "WF" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "GE" => %{length: 22, rule: ~r/^[0-9A-Z]{2}[0-9]{16}$/i},
    "DE" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "GI" => %{length: 23, rule: ~r/^[A-Z]{4}[0-9A-Z]{15}$/i},
    "GR" => %{length: 27, rule: ~r/^[0-9]{7}[0-9A-Z]{16}$/i},
    "GL" => %{length: 18, rule: ~r/^[0-9]{14}$/i},
    "HU" => %{length: 28, rule: ~r/^[0-9]{24}$/i},
    "IS" => %{length: 26, rule: ~r/^[0-9]{22}$/i},
    "IE" => %{length: 22, rule: ~r/^[0-9A-Z]{4}[0-9]{14}$/i},
    "IL" => %{length: 23, rule: ~r/^[0-9]{19}$/i},
    "IT" => %{length: 27, rule: ~r/^[A-Z][0-9]{10}[0-9A-Z]{12}$/i},
    "KZ" => %{length: 20, rule: ~r/^[0-9]{3}[0-9A-Z]{3}[0-9]{10}$/i},
    "KW" => %{length: 30, rule: ~r/^[A-Z]{4}[0-9]{22}$/i},
    "LV" => %{length: 21, rule: ~r/^[A-Z]{4}[0-9A-Z]{13}$/i},
    "LB" => %{length: 28, rule: ~r/^[0-9]{4}[0-9A-Z]{20}$/i},
    "LI" => %{length: 21, rule: ~r/^[0-9]{5}[0-9A-Z]{12}$/i},
    "LT" => %{length: 20, rule: ~r/^[0-9]{16}$/i},
    "LU" => %{length: 20, rule: ~r/^[0-9]{3}[0-9A-Z]{13}$/i},
    "MK" => %{length: 19, rule: ~r/^[0-9]{3}[0-9A-Z]{10}[0-9]{2}$/i},
    "MT" => %{length: 31, rule: ~r/^[A-Z]{4}[0-9]{5}[0-9A-Z]{18}$/i},
    "MR" => %{length: 27, rule: ~r/^[0-9]{23}$/i},
    "MU" => %{length: 30, rule: ~r/^[A-Z]{4}[0-9]{19}[A-Z]{3}$/i},
    "MC" => %{length: 27, rule: ~r/^[0-9]{10}[0-9A-Z]{11}[0-9]{2}$/i},
    "ME" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "NL" => %{length: 18, rule: ~r/^[A-Z]{4}[0-9]{10}$/i},
    "NO" => %{length: 15, rule: ~r/^[0-9]{11}$/i},
    "PL" => %{length: 28, rule: ~r/^[0-9]{24}$/i},
    "PT" => %{length: 25, rule: ~r/^[0-9]{21}$/i},
    "RO" => %{length: 24, rule: ~r/^[A-Z]{4}[0-9A-Z]{16}$/i},
    "SM" => %{length: 27, rule: ~r/^[A-Z][0-9]{10}[0-9A-Z]{12}$/i},
    "SA" => %{length: 24, rule: ~r/^[0-9]{2}[0-9A-Z]{18}$/i},
    "RS" => %{length: 22, rule: ~r/^[0-9]{18}$/i},
    "SK" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "SI" => %{length: 19, rule: ~r/^[0-9]{15}$/i},
    "ES" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "SE" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "CH" => %{length: 21, rule: ~r/^[0-9]{5}[0-9A-Z]{12}$/i},
    "TN" => %{length: 24, rule: ~r/^[0-9]{20}$/i},
    "TR" => %{length: 26, rule: ~r/^[0-9]{5}[0-9A-Z]{17}$/i},
    "AE" => %{length: 23, rule: ~r/^[0-9]{19}$/i},
    "GB" => %{length: 22, rule: ~r/^[A-Z]{4}[0-9]{14}$/i},
    "CI" => %{length: 28, rule: ~r/^[0-9A-Z]{2}[0-9]{22}$/i}
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
  @spec format_compact(String.t) :: String.t
  def format_compact(iban) do
    parse(iban)
  end


  @doc """
  Formats and returns a given IBAN in pretty format.

  ## Examples
      iex> Bankster.Iban.format_pretty("DK8387188644726815")
      "DK838 7188 64472 6815"
  """
  @spec format_pretty(String.t) :: String.t
  def format_pretty(iban) do
    Regex.scan(~r/.{1,4}/, format_compact(iban))
    |> List.flatten
    |> Enum.join(" ")
  end


  @doc """
  Formats and returns a given IBAN in pretty format.

  ## Examples
      iex> Bankster.Iban.country_code("DK8387188644726815")
      "DK"
  """
  @spec country_code(String.t) :: String.t
  def country_code(iban) do
    iban
    |> format_compact
    |> String.slice(0..1)
  end


  @doc """
  Formats and returns a given IBAN in pretty format.

  ## Examples
      iex> Bankster.Iban.bban("DK8387188644726815")
      "83"
  """
  @spec bban(String.t) :: String.t
  def bban(iban) do
    iban
    |> format_compact
    |> String.slice(2..3)
  end


  @doc """
  Formats and returns a given IBAN in pretty format.

  ## Examples
      iex> Bankster.Iban.size("DK 8387   188644     726815")
      18
  """
  @spec size(String.t) :: Integer.t
  def size(iban) do
    iban
    |> format_compact
    |> String.length
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
  @spec validate(String.t) :: {:ok, String.t} | {:error, Atom.t}
  def validate(iban) do
    cond do
      iban_violates_country?(iban) ->
        {:error, :invalid_country}
      iban_violates_length?(iban) ->
        {:error, :invalid_length}
      iban_violates_match?(iban) ->
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
  @spec valid?(String.t) :: boolean
  def valid?(iban) do
    case validate(iban) do
      {:ok, _}    -> true
      _ -> false
    end
  end


  ##################################################
  ## HELPERS
  defp parse(iban) when is_binary(iban) do
    iban
    |> String.replace(~r/\s*/, "")
    |> String.upcase
  end
  defp parse(_) do
    ""
  end

  defp iban_violates_country?(iban) do
    !Map.has_key?(@iban_rules, country_code(iban))
  end

  defp iban_violates_length?(iban) do
    size(iban) != get_in(@iban_rules, [country_code(iban), :length])
  end

  defp iban_violates_match?(iban) do
    if iban_rule = get_in(@iban_rules, [country_code(iban), :rule]) do
      !Regex.match?(iban_rule, String.slice(parse(iban), 4..-1))
    else
      false
    end
  end

  defp iban_violates_checksum?(iban) do
    (for <<c <- (String.slice(parse(iban), 4..-1) <> String.slice(parse(iban), 0, 4))>>, into: "", do: (@replacements[<<c>>] || <<c>>))
    |> String.to_integer
    |> rem(97) !== 1
  end
end
