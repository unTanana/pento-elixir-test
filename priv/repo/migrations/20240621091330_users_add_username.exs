defmodule Pento.Repo.Migrations.UsersAddUsername do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :username, :text
    end
  end
end
