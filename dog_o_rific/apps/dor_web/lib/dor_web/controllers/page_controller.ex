defmodule DorWeb.PageController do
  use DorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
