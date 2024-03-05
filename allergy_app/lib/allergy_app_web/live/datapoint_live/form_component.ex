defmodule AllergyAppWeb.DatapointLive.FormComponent do
  use AllergyAppWeb, :live_component

  alias AllergyApp.Allergy

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage datapoint records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="datapoint-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:medicine]} type="checkbox" label="Medicine" />
        <.input field={@form[:medicinetype]} type="text" label="Medicinetype" />
        <.input field={@form[:region]} type="text" label="Region" />
        <.input field={@form[:symptom]} type="text" label="Symptom" />
        <.input field={@form[:intensity]} type="number" label="Intensity" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Datapoint</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{datapoint: datapoint} = assigns, socket) do
    changeset = Allergy.change_datapoint(datapoint)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"datapoint" => datapoint_params}, socket) do
    changeset =
      socket.assigns.datapoint
      |> Allergy.change_datapoint(datapoint_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"datapoint" => datapoint_params}, socket) do
    save_datapoint(socket, socket.assigns.action, datapoint_params)
  end

  defp save_datapoint(socket, :edit, datapoint_params) do
    case Allergy.update_datapoint(socket.assigns.datapoint, datapoint_params) do
      {:ok, datapoint} ->
        notify_parent({:saved, datapoint})

        {:noreply,
         socket
         |> put_flash(:info, "Datapoint updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_datapoint(socket, :new, datapoint_params) do
    case Allergy.create_datapoint(datapoint_params) do
      {:ok, datapoint} ->
        notify_parent({:saved, datapoint})

        {:noreply,
         socket
         |> put_flash(:info, "Datapoint created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
