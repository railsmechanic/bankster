defmodule Bankster.Bic do
  @moduledoc """
  Module provides some SWIFT BIC related functions.

  See: https://en.wikipedia.org/wiki/ISO_9362
  """

  defstruct [:bank, :country, :location, :branch]

  @type t :: %__MODULE__{
          bank: binary(),
          country: binary(),
          location: binary(),
          branch: binary() | nil
        }

  @bic_regex ~r/^(?<bank>[a-zA-Z]{4})\s*(?<country>[a-zA-Z]{2})\s*(?<location>[0-9a-zA-Z]{2})\s*(?<branch>[0-9a-zA-Z]{3})?$/

  @doc """
  Parses a BIC string into its components.

  ## Examples
    iex> Bankster.Bic.parse("INVALIDBIC")
    :error

    iex> Bankster.Bic.parse("AAAABBCC123")
    %Bankster.Bic{bank: "AAAA", country: "BB", location: "CC", branch: "123"}

    iex> Bankster.Bic.parse("AAAABBCC")
    %Bankster.Bic{bank: "AAAA", country: "BB", location: "CC", branch: nil}

    iex> Bankster.Bic.parse("AAAA BB CC 123")
    %Bankster.Bic{bank: "AAAA", country: "BB", location: "CC", branch: "123"}

    iex> Bankster.Bic.parse("AAAA BB CC")
    %Bankster.Bic{bank: "AAAA", country: "BB", location: "CC", branch: nil}

    iex> Bankster.Bic.parse("AAAA BB CC     123")
    %Bankster.Bic{bank: "AAAA", country: "BB", location: "CC", branch: "123"}
  """
  @spec parse(term()) :: {:ok, t()} | :error
  def parse(bic) when is_binary(bic) do
    case Regex.named_captures(@bic_regex, bic) do
      nil ->
        :error

      captures ->
        {
          :ok,
          %__MODULE__{
            bank: captures["bank"],
            country: captures["country"],
            location: captures["location"],
            branch: presence(captures["branch"])
          }
        }
    end
  end

  def parse(_), do: :error

  @doc """
  Parses a BIC string into its components.

  Will raise `ArgumentError` if the value can not be parsed.
  """
  @spec parse!(term()) :: t()
  def parse!(bic) do
    case parse(bic) do
      {:ok, parsed} ->
        parsed

      :error ->
        raise ArgumentError, message: "invalid argument bic: #{inspect(bic)}"
    end
  end

  @doc """
  Turns a `Bankster.Bic` into a string.

  ## Options

  * `:format` - Specifies the format to use when encoding.
  * `:case` - Specifies the character case when encoding.

  The values for `:format` can be:

  * `:compact` - No spaces between components. (default)
  * `:pretty` - Adds spaces between components

  The values for `:case` can be:

  * `:upper` - All characters are made to be upper case. (default)
  * `:lower` - All characters are made to be lower case.
  * `:leave` - Leaves the characters in the case they are in.
  """
  @spec to_string(t()) :: binary()
  @spec to_string(t(), [{:format, :pretty | :compact}]) :: binary()
  def to_string(
        %__MODULE__{bank: bank, country: country, location: location, branch: branch} = bic,
        opts \\ []
      ) do
    if bank == nil do
      raise ArgumentError, ":bank is required, got: #{inspect(bic)}"
    end

    if country == nil do
      raise ArgumentError, ":country is required, got: #{inspect(bic)}"
    end

    if location == nil do
      raise ArgumentError, ":location is required, got: #{inspect(bic)}"
    end

    string =
      case opts[:format] do
        :pretty ->
          if branch do
            "#{bank} #{country} #{location} #{branch}"
          else
            "#{bank} #{country} #{location}"
          end

        _ ->
          "#{bank}#{country}#{location}#{branch}"
      end

    case opts[:case] do
      :leave -> string
      :lower -> String.downcase(string)
      _ -> String.upcase(string)
    end
  end

  @doc """
  Validates a given string whether it's a valid SWIFT BIC.

  > #### Note {: .info}
  > This ignores whitespace between the components.

  ## Examples
    iex> Bankster.Bic.valid?("INVALIDBIC")
    false

    iex> Bankster.Bic.valid?("AAAABBCC123")
    true

    iex> Bankster.Bic.valid?("AAAABBCC")
    true

    iex> Bankster.Bic.valid?("AAAA BB CC 123")
    true
  """
  @spec valid?(binary()) :: boolean()
  def valid?(bic) when is_binary(bic), do: Regex.match?(@bic_regex, bic)
  def valid?(_), do: false

  defp presence(""), do: nil
  defp presence(val), do: val
end

defimpl String.Chars, for: Bankster.Bic do
  defdelegate to_string(bic), to: Bankster.Bic
end
