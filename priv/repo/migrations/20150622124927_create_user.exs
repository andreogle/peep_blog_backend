defmodule PeepBlogBackend.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :text
      add :email, :text

      timestamps
    end

  end
end
