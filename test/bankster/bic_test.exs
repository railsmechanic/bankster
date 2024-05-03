defmodule Bankster.Bic.BicTest do
  use ExUnit.Case

  alias Bankster.Bic

  @valid_bics [
    "RBOSGGSX",
    "RBOS GG SX",
    "RBOS GGSX",
    "RBOSGG SX",
    "RZTIAT22263",
    "RZTI AT 22 263",
    "RZTI AT 22263",
    "RZTI AT22263",
    "RZTIAT22 263",
    "RZTI  AT  22263",
    "BCEELULL",
    "MARKDEFF",
    "GENODEF1JEV",
    "UBSWCHZH80A",
    "CEDELULLXXX"
  ]

  @invalid_bics ["CE1EL2LLFFF", "E31DCLLFFF", "", " ", nil, "INVALIDBIC"]

  describe "valid?" do
    test "valid bics" do
      for bic <- @valid_bics, do: assert(Bic.valid?(bic) == true)
    end

    test "invalid bics" do
      for bic <- @invalid_bics, do: assert(Bic.valid?(bic) == false)
    end
  end

  describe "parse" do
    test "invalid bics" do
      for bic <- @invalid_bics do
        assert :error = Bic.parse(bic)
      end

      assert :error = Bic.parse("  AAAABBCC123")
      assert :error = Bic.parse(nil)
      assert :error = Bic.parse(~D[2020-01-01])
    end

    test "valid bics" do
      for bic <- @valid_bics do
        assert {:ok, _} = Bic.parse(bic)
      end

      assert {:ok, bic} = Bic.parse("RBOSGGSX")
      assert %{bank: "RBOS", country: "GG", location: "SX", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("RZTIAT22263")
      assert %Bic{bank: "RZTI", country: "AT", location: "22", branch: "263"} = bic

      assert {:ok, bic} = Bic.parse("RZTIAT22 263")
      assert %Bic{bank: "RZTI", country: "AT", location: "22", branch: "263"} = bic

      assert {:ok, bic} = Bic.parse("RZTIAT 22 263")
      assert %Bic{bank: "RZTI", country: "AT", location: "22", branch: "263"} = bic

      assert {:ok, bic} = Bic.parse("RZTI AT22 263")
      assert %Bic{bank: "RZTI", country: "AT", location: "22", branch: "263"} = bic

      assert {:ok, bic} = Bic.parse("BCEELULL")
      assert %Bic{bank: "BCEE", country: "LU", location: "LL", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("MARKDEFF")
      assert %Bic{bank: "MARK", country: "DE", location: "FF", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("MARK DE FF")
      assert %Bic{bank: "MARK", country: "DE", location: "FF", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("MARK DEFF")
      assert %Bic{bank: "MARK", country: "DE", location: "FF", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("MARKDE FF")
      assert %Bic{bank: "MARK", country: "DE", location: "FF", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("MARK   DE   FF")
      assert %Bic{bank: "MARK", country: "DE", location: "FF", branch: nil} = bic

      assert {:ok, bic} = Bic.parse("markdeff")
      assert %Bic{bank: "mark", country: "de", location: "ff", branch: nil} = bic
    end
  end

  describe "parse!" do
    test "valid bic" do
      assert %Bic{
               bank: "mark",
               country: "de",
               location: "ff",
               branch: nil
             } = Bic.parse!("markdeff")
    end

    test "invalid bic raises an argument error" do
      assert_raise(ArgumentError, ~s(invalid argument bic: "CE1EL2LLFFF"), fn ->
        Bic.parse!("CE1EL2LLFFF")
      end)
    end
  end

  describe "to_string" do
    test "formatting options" do
      bic11 = %Bic{bank: "AaAa", country: "bB", location: "cC", branch: "123"}
      bic8 = %Bic{bank: "AaAa", country: "bB", location: "cC", branch: nil}

      assert "AAAABBCC123" == Bic.to_string(bic11)
      assert "AAAABBCC123" == Bic.to_string(bic11, case: :upper)
      assert "aaaabbcc123" == Bic.to_string(bic11, case: :lower)
      assert "AaAabBcC123" == Bic.to_string(bic11, case: :leave)
      assert "AAAABBCC123" == Bic.to_string(bic11, case: :upper, format: :compact)
      assert "aaaabbcc123" == Bic.to_string(bic11, case: :lower, format: :compact)
      assert "AaAabBcC123" == Bic.to_string(bic11, case: :leave, format: :compact)
      assert "AAAA BB CC 123" == Bic.to_string(bic11, case: :upper, format: :pretty)
      assert "aaaa bb cc 123" == Bic.to_string(bic11, case: :lower, format: :pretty)
      assert "AaAa bB cC 123" == Bic.to_string(bic11, case: :leave, format: :pretty)

      assert "AAAABBCC" == Bic.to_string(bic8)
      assert "AAAABBCC" == Bic.to_string(bic8, case: :upper)
      assert "aaaabbcc" == Bic.to_string(bic8, case: :lower)
      assert "AaAabBcC" == Bic.to_string(bic8, case: :leave)
      assert "AAAABBCC" == Bic.to_string(bic8, case: :upper, format: :compact)
      assert "aaaabbcc" == Bic.to_string(bic8, case: :lower, format: :compact)
      assert "AaAabBcC" == Bic.to_string(bic8, case: :leave, format: :compact)
      assert "AAAA BB CC" == Bic.to_string(bic8, case: :upper, format: :pretty)
      assert "aaaa bb cc" == Bic.to_string(bic8, case: :lower, format: :pretty)
      assert "AaAa bB cC" == Bic.to_string(bic8, case: :leave, format: :pretty)

      assert "AAAABBCC123" == String.Chars.to_string(bic11)
      assert "AAAABBCC" == String.Chars.to_string(bic8)

      assert_raise(ArgumentError, ~r/:bank is required, got:/, fn ->
        String.Chars.to_string(%Bic{bank: nil, country: "BB", location: "CC", branch: "123"})
      end)

      assert_raise(ArgumentError, ~r/:country is required, got:/, fn ->
        String.Chars.to_string(%Bic{bank: "AAAA", country: nil, location: "CC", branch: "123"})
      end)

      assert_raise(ArgumentError, ~r/:location is required, got:/, fn ->
        String.Chars.to_string(%Bic{bank: "AAAA", country: "BB", location: nil, branch: "123"})
      end)
    end
  end
end
