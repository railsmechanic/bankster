defmodule Bankster.Bic.BicTest do
  use ExUnit.Case

  @valid_bics [
    "RBOSGGSX",
    "RZTIAT22263",
    "BCEELULL",
    "MARKDEFF",
    "GENODEF1JEV",
    "UBSWCHZH80A",
    "CEDELULLXXX"
  ]
  @invalid_bics ["CE1EL2LLFFF", "E31DCLLFFF", "", " ", nil]

  test "valid?/1" do
    ## -- VALID BICS
    for bic <- @valid_bics, do: assert(Bankster.Bic.valid?(bic) == true)

    ## -- INVALID BICS
    for bic <- @invalid_bics, do: assert(Bankster.Bic.valid?(bic) == false)
  end
end
