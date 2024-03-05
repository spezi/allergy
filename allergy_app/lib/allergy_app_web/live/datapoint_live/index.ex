defmodule AllergyAppWeb.DatapointLive.Index do
  use AllergyAppWeb, :live_view

  alias AllergyApp.Allergy
  alias AllergyApp.Allergy.Datapoint

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :datapoints, Allergy.list_datapoints())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Datapoint")
    |> assign(:datapoint, Allergy.get_datapoint!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Datapoint")
    |> assign(:datapoint, %Datapoint{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Datapoints")
    |> assign(:datapoint, nil)
  end

  @impl true
  def handle_info({AllergyAppWeb.DatapointLive.FormComponent, {:saved, datapoint}}, socket) do
    {:noreply, stream_insert(socket, :datapoints, datapoint)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    datapoint = Allergy.get_datapoint!(id)
    {:ok, _} = Allergy.delete_datapoint(datapoint)

    {:noreply, stream_delete(socket, :datapoints, datapoint)}
  end
end
