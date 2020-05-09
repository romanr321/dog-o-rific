defmodule DorWeb.Api.BreedController do
  use DorWeb, :controller

  def index(conn, _params) do
    breeds = Dor.get_breeds()
    render conn, "index.json", breeds: breeds
  end

  def show(conn, %{"id" => id}) do
    with id <- String.to_integer(id),
      true <- is_integer(id),
      {:ok, breed} <- IO.inspect(Dor.get_breeds(id))
      do render conn, "show.json", breed: breed
      else
        _error ->
          Plug.Conn.send_resp(conn, 404, "Not found")
    end
  end
end
