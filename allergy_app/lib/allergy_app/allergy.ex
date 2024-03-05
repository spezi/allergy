defmodule AllergyApp.Allergy do
  @moduledoc """
  The Allergy context.
  """

  import Ecto.Query, warn: false
  alias AllergyApp.Repo

  alias AllergyApp.Allergy.Datapoint

  @doc """
  Returns the list of datapoints.

  ## Examples

      iex> list_datapoints()
      [%Datapoint{}, ...]

  """
  def list_datapoints do
    Repo.all(Datapoint)
  end

  @doc """
  Gets a single datapoint.

  Raises `Ecto.NoResultsError` if the Datapoint does not exist.

  ## Examples

      iex> get_datapoint!(123)
      %Datapoint{}

      iex> get_datapoint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_datapoint!(id), do: Repo.get!(Datapoint, id)

  @doc """
  Creates a datapoint.

  ## Examples

      iex> create_datapoint(%{field: value})
      {:ok, %Datapoint{}}

      iex> create_datapoint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_datapoint(attrs \\ %{}) do
    %Datapoint{}
    |> Datapoint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a datapoint.

  ## Examples

      iex> update_datapoint(datapoint, %{field: new_value})
      {:ok, %Datapoint{}}

      iex> update_datapoint(datapoint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_datapoint(%Datapoint{} = datapoint, attrs) do
    datapoint
    |> Datapoint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a datapoint.

  ## Examples

      iex> delete_datapoint(datapoint)
      {:ok, %Datapoint{}}

      iex> delete_datapoint(datapoint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_datapoint(%Datapoint{} = datapoint) do
    Repo.delete(datapoint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking datapoint changes.

  ## Examples

      iex> change_datapoint(datapoint)
      %Ecto.Changeset{data: %Datapoint{}}

  """
  def change_datapoint(%Datapoint{} = datapoint, attrs \\ %{}) do
    Datapoint.changeset(datapoint, attrs)
  end
end
