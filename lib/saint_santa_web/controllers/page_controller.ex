defmodule SaintSantaWeb.PageController do
  use SaintSantaWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
