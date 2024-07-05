defmodule Pento.PromoTest do
  @moduledoc false

  use Pento.DataCase
  alias Pento.Promo
  import Pento.PromoFixtures

  describe "promo" do
    # alias Pento.Promo.Recipient

    test "change a valid promo recipients email" do
      recipient = promo_fixture()

      %Ecto.Changeset{changes: changes} =
        Promo.change_recipient(recipient, %{email: "test@email.com", first_name: "New First Name"})

      assert changes.email == "test@email.com"
      assert changes.first_name == "New First Name"
    end

    test "fail to change a valid promo recipients email with an invalid email" do
      recipient = promo_fixture()

      changeset = Promo.change_recipient(recipient, %{email: "bad email"})

      assert errors_on(changeset).email
    end
  end
end
