defmodule Bankster.Bic.BicTest do
  use ExUnit.Case

  test "valid SWIFT BICs" do
    for bic <- ["RBOSGGSX", "RZTIAT22263", "BCEELULL", "MARKDEFF", "GENODEF1JEV", "UBSWCHZH80A", "CEDELULLXXX"], do: assert Bankster.Bic.valid?(bic) == true
  end

  test "invalid SWIFT BICs" do
    for bic <- ["CE1EL2LLFFF", "E31DCLLFFF", "", " ", nil], do: assert Bankster.Bic.valid?(bic) == false
  end
end
