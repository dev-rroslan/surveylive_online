defmodule SurveyliveOnlineWeb.Admin.UserLive.Index do
  @moduledoc """
  The admin users index page
  """
  use SurveyliveOnlineWeb, :live_view
  import SaasKit.LiveComponents.DataTable
  import SurveyliveOnlineWeb.Live.Admin.LiveHelpers
  import SurveyliveOnlineWeb.Components.Cards, only: [card: 1]

  alias SurveyliveOnline.Users
  alias SurveyliveOnline.Users.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {
      :noreply,
      socket
      |> assign(:params, params)
      |> apply_action(socket.assigns.live_action, params)
    }
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User")
    |> assign(:user, %User{})
  end

  defp apply_action(socket, :index, params) do
    socket
    |> assign(:page_title, "Listing Users")
    |> assign(:user, nil)
    |> assign(get_users_assigns(params))
    |> pagination_assigns()
    |> assign(:params, params)
  end

  defp get_users_assigns(params) do
    case Users.paginate_users(params) do
      {:ok, assigns} -> assigns
      _ -> %{}
    end
  end
end
