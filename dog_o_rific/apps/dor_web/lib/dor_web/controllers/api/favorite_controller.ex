defmodule DorWeb.Api.FavoriteController do
  use DorWeb, :controller

  def index(conn, _params) do
    favorites = Dor.get_favorites()
    render conn, "index.json", favorites: favorites
  end

  def show(conn, %{"id" => id}) do
    with id <- String.to_integer(id),
        {:ok, favorite} <- IO.inspect(Dor.get_favorites(id))
    do render conn, "show.json", favorite: favorite
    else
      _error ->
        Plug.Conn.send_resp(conn, 404, "Not Found")
    end
  end

  def create(conn, %{"_json" => post}) do
    try do
       %{"breed_id" => id} = Jason.decode!(post)
      :ok = Dor.add_favorite(id)
      Plug.Conn.send_resp(conn, 204, "")
    catch
      {:error, reason} -> Plug.Conn.send_resp(conn, 409, reason)
    rescue
     e in MatchError -> {:error, message} = e.term
      Plug.Conn.send_resp(conn, 409, message)
     error -> Plug.Conn.send_resp(conn, 500, "#{inspect(error)}")
    end
  end

  def delete(conn, %{"id" => id}) do
    Dor.delete_favorite(String.to_integer(id))
    Plug.Conn.send_resp(conn, 204, "")
  end

end
