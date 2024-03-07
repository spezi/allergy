defmodule AllergyAppWeb.DatapointLive.FormComponent do
  use AllergyAppWeb, :live_component

  alias AllergyApp.Allergy

  @impl true
  def render(assigns) do
    #dbg(assigns)
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
        <.input field={@form[:user_id]} type="hidden" label="Medicine" value={@user_id}/>
        <.input field={@form[:medicine]} type="checkbox" label="Medicine" />
        <.input :if={@medicine} field={@form[:medicinetype]} type="select" label="Medicinetype" options={@options.medizinetype} />
        <.input field={@form[:region]} type="select" label="Region" options={@options.region} />
        <.input field={@form[:symptom]} type="select" label="Symptom" options={@options.symptom} />
        <.input field={@form[:intensity]} type="checkbox-intensity" label="Intensity" intensity={assigns.form.source.changes[:intensity]} />
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
    #form[:changes].form.source.changes[:medicine]
    dbg(datapoint_params)

    #datapoint_params = Map.put(datapoint_params, :user_id, socket.assigns.current_user.id)
    #dbg(datapoint_params)

    changeset =
      socket.assigns.datapoint
      |> Allergy.change_datapoint(datapoint_params)
      |> Map.put(:action, :validate)

    {:noreply,
      assign_form(socket, changeset)
      |> assign(:medicine, changeset.changes[:medicine])
    }
  end

  def handle_event("save", %{"datapoint" => datapoint_params}, socket) do
    save_datapoint(socket, socket.assigns.action, datapoint_params)
  end

  @impl true
  def handle_event("set_intensity", %{"intensity" => intensity}, socket) do
    dbg(intensity)
    dbg(socket.assigns.form.params)
    #dbg()

    params = Map.replace(socket.assigns.form.params, "intensity", intensity)
    #params = %{
    #  "intensity" => intensity
    #}

    changeset =
      socket.assigns.datapoint
      |> Allergy.change_datapoint(params)
      |> Map.put(:action, :validate)

    dbg(changeset)
    {:noreply,
      assign_form(socket, changeset)
    }
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
