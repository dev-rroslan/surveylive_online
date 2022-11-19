defmodule SurveyliveOnlineWeb.Admin.UserLive.Show do
  @moduledoc """
  The admin users show page. Also includes a list of memberships.
  """
  use SurveyliveOnlineWeb, :live_view
  import SurveyliveOnlineWeb.Live.Admin.LiveHelpers
  import SurveyliveOnlineWeb.Components.Cards, only: [card: 1]

  alias SurveyliveOnline.Users

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    user =
      Users.get_user!(id)
      |> Users.with_memberships()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user, user)
     |> assign(:memberships, user.memberships)}
  end

  defp page_title(:show), do: "Show User"
  defp page_title(:edit), do: "Edit User"
end
