defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :provider, :string
      add :token, :string

      timestamps()
   end
  end
end
#to add migrations just use mix ecto.gen.migrations add_users (add users is specific to this one)
#to migrate after making do this  mix ecto.migrate
#this is not enough after a migrate file we need to make a models file
