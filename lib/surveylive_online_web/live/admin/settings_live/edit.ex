defmodule SurveyliveOnlineWeb.Admin.SettingLive.Edit do
  @moduledoc """
  The admin settings page for updating email and password
  """
  use SurveyliveOnlineWeb, :live_view
  import SurveyliveOnlineWeb.Live.Admin.LiveHelpers
  import SurveyliveOnlineWeb.Components.Cards, only: [card: 1]

  alias SurveyliveOnline.Admins

  @impl true
  def mount(_params, %{"current_admin_id" => id}, socket) do
    admin = Admins.get_admin!(id)

    {
      :ok,
      socket
      |> assign(:page_title, "Settings")
      |> assign(:admin, admin)
    }
  end
end
