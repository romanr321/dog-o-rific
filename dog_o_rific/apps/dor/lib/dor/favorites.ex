defmodule Dor.Favorites do
  alias Dor.NewFavorite
  alias Dor.Favorite

    @moduledoc """
    Favorites module gives access to the favorites objects

  """

  def get(nil) do
    try do
      fav_recs = Dor.Repo.all(Favorite)
      favs = Enum.map(fav_recs, fn fav_struct -> %{"id" => fav_struct.id, "breed" => :erlang.binary_to_term(fav_struct.breed)} end)
      favs
    rescue
      error -> {:error, inspect(error)}
    catch
      error -> {:error, inspect(error)}
    end
  end

  def get(id) do
    try do
      fav_struct =  Dor.Repo.get(Favorite, id)
      case fav_struct == nil do
        true -> {:error, "not found"}
        _ ->
          fav = %{"id" => fav_struct.id, "breed" => :erlang.binary_to_term(fav_struct.breed)}
          {:ok, fav}
      end
    rescue
      error -> {:error, "can't retrieve data"}
    catch
      error -> {:error, "can't retrieve data"}
    end
  end

  def add(breed_id) when is_integer(breed_id) do
    try do
      {:ok, _} = %NewFavorite{breed_id: breed_id}
      |> Dor.Repo.insert
      :ok
    rescue
      error -> {:error, inspect(error)}
    catch
      error -> {:error, inspect(error)}
    end

  end

  def delete(id) when is_integer(id) do
    with fav_struct <- Dor.Repo.get(NewFavorite, id),
      {"found record:", true} <- {"found record:", fav_struct != nil},
      {:ok, _} <- Dor.Repo.delete(fav_struct)
    do :ok
    else
      error -> {:error, "Failed to delete favorite, reason: #{inspect(error)}"}
    end
  end

end
