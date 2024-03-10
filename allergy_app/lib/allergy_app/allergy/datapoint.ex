defmodule AllergyApp.Allergy.Datapoint do
  use Ecto.Schema
  import Ecto.Changeset

  schema "datapoints" do
    field :intensity, :integer
    field :medicine, :boolean, default: false
    field :medicinetype, :string
    field :region, :string
    field :symptom, :string
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(datapoint, attrs) do
    datapoint
    |> cast(attrs, [:medicine, :medicinetype, :region, :symptom, :intensity, :user_id])
    |> validate_required([:medicine, :region, :symptom, :intensity, :user_id])
  end
end
