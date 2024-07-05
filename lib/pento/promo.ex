defmodule Pento.Promo do
  @moduledoc """
  Module handling Promotional codes
  """
  alias Pento.Promo.Recipient
  alias Pento.Accounts.UserNotifier

  def change_recipient(%Recipient{} = recipient, attrs \\ %{}) do
    Recipient.changeset(recipient, attrs)
  end

  def send_promo(%Recipient{} = recipient, code) do
    UserNotifier.send_email(recipient, "You received a promotion buddy!", """
    Hi #{recipient.first_name}

    Your promo code is #{code}

    Enjoy!
    """)
  end
end
