defmodule AllergyApp.AllergyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AllergyApp.Allergy` context.
  """

  @doc """
  Generate a datapoint.
  """
  def datapoint_fixture(attrs \\ %{}) do
    {:ok, datapoint} =
      attrs
      |> Enum.into(%{
         : "some  "
      })
      |> AllergyApp.Allergy.create_datapoint()

    datapoint
  end

  @doc """
  Generate a datapoint.
  """
  def datapoint_fixture(attrs \\ %{}) do
    {:ok, datapoint} =
      attrs
      |> Enum.into(%{
        intensity: 42,
        medicine: true,
        medicinetype: "some medicinetype",
        region: "some region",
        symptom: "some symptom"
      })
      |> AllergyApp.Allergy.create_datapoint()

    datapoint
  end
end
