defmodule SurveyliveOnline.Admins.AdminNotifierTest do
  use SurveyliveOnline.DataCase, async: true

  alias SurveyliveOnline.Admins.AdminNotifier

  test "admin login link email" do
    message = %{url: ~s(#somelinkwithtoken), email: "john.doe@example.com"}

    email = AdminNotifier.admin_login_link(message)

    assert email.to == [{"", "john.doe@example.com"}]
    assert email.from == {"", "john.doe@surveylive_online.com"}
    assert email.html_body =~ "href=\"#somelinkwithtoken\""
  end
end
