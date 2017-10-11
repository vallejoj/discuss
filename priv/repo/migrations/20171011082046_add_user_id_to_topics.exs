defmodule Discuss.Repo.Migrations.AddUserIdToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics) do
      add :user_id, references(:users) # this is how we join tables
    end
  end
end
