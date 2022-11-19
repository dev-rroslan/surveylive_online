defmodule SurveyliveOnline.Admins.Pipeline do
  @moduledoc """
  This pipeline handles the Admin authentication with Guardian.
  """
  use Guardian.Plug.Pipeline,
    otp_app: :surveylive_online,
    error_handler: SurveyliveOnline.Admins.ErrorHandler,
    module: SurveyliveOnline.Admins.Guardian,
    key: :admin

  # If there is a session token, restrict it to an access token and validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  # If there is an authorization header, restrict it to an access token and validate it
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true, key: :admin

  # Set current admin
  plug SurveyliveOnlineWeb.Plugs.SetCurrentAdmin

  # Set current admin account - when using account swithcher in admin
  plug SurveyliveOnlineWeb.Plugs.SetCurrentAdminAccount
end
