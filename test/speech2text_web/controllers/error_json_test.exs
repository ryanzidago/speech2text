defmodule Speech2textWeb.ErrorJSONTest do
  use Speech2textWeb.ConnCase, async: true

  test "renders 404" do
    assert Speech2textWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert Speech2textWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
