defmodule AllergyAppWeb.DatapointLive.Show do
  use AllergyAppWeb, :live_view

  alias AllergyApp.Allergy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:datapoint, Allergy.get_datapoint!(id))}
  end

  defp page_title(:show), do: "Show Datapoint"
  defp page_title(:edit), do: "Edit Datapoint"
end
