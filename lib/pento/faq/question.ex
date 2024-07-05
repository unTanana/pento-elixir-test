defmodule Pento.FAQ.Question do
  @moduledoc """
  The FAQ.Question module.
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string
    field :answer, :string
    field :votes, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question])
    |> add_default_votes_if_missing()
    |> validate_required([:question])
  end

  @doc false
  def answer_changeset(question, attrs) do
    question
    |> cast(attrs, [:answer])
    |> validate_required([:answer])
  end

  defp add_default_votes_if_missing(
         %Ecto.Changeset{data: %Pento.FAQ.Question{votes: nil}} = changeset
       ) do
    changeset |> put_change(:votes, 0)
  end

  defp add_default_votes_if_missing(%Ecto.Changeset{changes: %{votes: _}} = changeset) do
    changeset
  end

  # if it doesn't match anything above, continue
  defp add_default_votes_if_missing(changeset) do
    changeset
  end
end
