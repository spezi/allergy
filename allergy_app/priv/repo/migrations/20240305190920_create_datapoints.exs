defmodule AllergyApp.Repo.Migrations.CreateDatapoints do
  use Ecto.Migration

  def change do
    create table(:datapoints) do
      add :medicine, :boolean, default: false, null: false
      add :medicinetype, :string
      add :region, :string
      add :symptom, :string
      add :intensity, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:datapoints, [:user_id])
  end
end
