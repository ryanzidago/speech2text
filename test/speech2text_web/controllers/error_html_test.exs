defmodule Speech2textWeb.ErrorHTMLTest do
  use Speech2textWeb.ConnCase, async: true

  # Bring render_to_string/4 for testing custom views
  import Phoenix.Template

  test "renders 404.html" do
    assert render_to_string(Speech2textWeb.ErrorHTML, "404", "html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(Speech2textWeb.ErrorHTML, "500", "html", []) == "Internal Server Error"
  end
end
