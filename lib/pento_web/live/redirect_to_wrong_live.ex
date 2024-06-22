defmodule PentoWeb.RedirectToWrongLive do
  use PentoWeb, :live_view

  def mount(_params, _session, socket) do
    # if current_user is not nil, redirect to the right page
    if socket.assigns.current_user do
      {:ok, push_navigate(socket, to: ~p"/guess")}
    else
      {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
    <div>You are on /route</div>
    """
  end
end
