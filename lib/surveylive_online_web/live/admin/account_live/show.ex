defmodule SurveyliveOnlineWeb.Admin.AccountLive.Show do
  @moduledoc """
  The admin accounts show page. Also includes a list of memberships.
  """
  use SurveyliveOnlineWeb, :live_view
  import SurveyliveOnlineWeb.Live.Admin.LiveHelpers
  import SurveyliveOnlineWeb.Components.Cards, only: [card: 1]

  alias SurveyliveOnline.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    account =
      Accounts.get_account!(id)
      |> Accounts.with_members()

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:account, account)
     |> assign(:memberships, account.memberships)}
  end

  defp page_title(:show), do: "Show Account"
  defp page_title(:edit), do: "Edit Account"
end
