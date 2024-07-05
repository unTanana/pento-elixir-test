defmodule Pento.PromoFixtures do
  alias Pento.Promo.Recipient

  @moduledoc """
  This module defines test helpers for creating promos

  """

  @doc """
  Generate a recipient.
  """
  def promo_fixture() do
    %Recipient{
      first_name: "some first name",
      email: "some@email.com"
    }
  end
end
