defmodule DorWeb.Api.FavoriteView do
  use DorWeb, :view

  def render("index.json", %{favorites: favorites}) do
    render_many(favorites, __MODULE__, "favorite.json")
  end

  def render("show.json", %{favorite: favorite}) do
      render_one(favorite, __MODULE__, "favorite.json")
  end

  def render("favorite.json", %{favorite: favorite}) do
   favorite
  end
end
