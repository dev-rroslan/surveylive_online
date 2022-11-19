defmodule SurveyliveOnlineWeb.Emails do
  @moduledoc """
  This viewmodule is responsible for rendering the emails and the layouts
  for emails using the Phoenix.Swoosh library

  Can be used in the notifier by adding:

      use Phoenix.Swoosh, view: SurveyliveOnlineWeb.Emails, layout: {SurveyliveOnlineWeb.Emails, :layout}

  """
  use Phoenix.View,
    root: "lib/surveylive_online_web",
    namespace: SurveyliveOnlineWeb

  use Phoenix.Component

  import SurveyliveOnlineWeb.AppInfo
end
