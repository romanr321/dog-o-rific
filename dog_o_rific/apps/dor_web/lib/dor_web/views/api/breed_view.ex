defmodule DorWeb.Api.BreedView do
  use DorWeb, :view

  def render("index.json", %{breeds: breeds}) do
    render_many(breeds, __MODULE__, "breed.json")
  end

  def render("show.json", %{breed: breed}) do
      render_one(breed, __MODULE__, "breed.json")
  end

  def render("breed.json", %{breed: breed}) do
   breed
  end
end
