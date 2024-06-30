defmodule PentoWeb.ProductLive.Show do
  alias PentoWeb.Endpoint
  use PentoWeb, :live_view

  alias Pento.Catalog

  @products_topic "product"

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Endpoint.subscribe(@products_topic)
    end

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, Catalog.get_product!(id))}
  end

  @impl true
  def handle_info(%{event: "product_updated", payload: %{product: product}}, socket) do
    {:noreply, assign(socket, :product, product)}
  end

  # handle notify_parent messages
  @impl true
  def handle_info({PentoWeb.ProductLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, assign(socket, :product, product)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
