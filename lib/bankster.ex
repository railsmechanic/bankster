defmodule Bankster do
  defdelegate bic_valid?(iban), to: Bankster.Bic, as: :valid?
  defdelegate iban_valid?(iban), to: Bankster.Iban, as: :valid?
end
