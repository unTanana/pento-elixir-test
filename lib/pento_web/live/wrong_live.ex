defmodule PentoWeb.WrongLive do
  use PentoWeb, :live_view

  def mount(_params, session, socket) do
    session_id = session["live_socket_id"]

    {:ok,
     assign(
       socket,
       score: 0,
       correct: Enum.random(1..10),
       message: "Take a guess!",
       guessed: false,
       time: time(),
       session_id: session_id
     )}
  end

  def render(assigns) do
    ~H"""
    <h1 class="text-4xl font-extrabold">Your score is: <%= @score %></h1>
    <h2 class="mt-4">
      <%= @message %> It's <%= @time %>
    </h2>
    <h3 class="mb-4">
      Session ID: <%= @session_id %>
    </h3>
    <%= if @guessed do %>
      <p class="text-green-500 mb-4">You guessed it! Good Job <%= @current_user.email %></p>

      <.button phx-click="restart" class="!bg-blue-500 !hover:bg-blue-700">
        Restart
      </.button>
    <% else %>
      <%= for n <- 1..10 do %>
        <.link
          class="bg-blue-500 hover:bg-blue-700
          text-white font-bold py-2 px-4 border border-blue-700 rounded m-1"
          phx-click="guess"
          phx-value-number={n}
        >
          <%= n %>
        </.link>
      <% end %>
    <% end %>
    """
  end

  def time do
    DateTime.utc_now() |> to_string()
  end

  def handle_event("guess", %{"number" => number}, socket) do
    {int_number, _} = Integer.parse(number)
    is_correct = int_number == socket.assigns.correct
    message = if is_correct, do: "You guessed it! Correct!", else: "Wrong! Guess again!"
    score = if is_correct, do: socket.assigns.score + 1, else: socket.assigns.score - 1
    # change the correct number if it was guessed
    correct = if is_correct, do: Enum.random(1..10), else: socket.assigns.correct

    {
      :noreply,
      assign(socket,
        correct: correct,
        guessed: is_correct,
        score: score,
        message: message,
        time: time()
      )
    }
  end

  def handle_event("restart", _, socket) do
    {:noreply,
     assign(socket,
       score: 0,
       correct: Enum.random(1..10),
       message: "Take a guess!",
       guessed: false,
       time: time()
     )}
  end
end
