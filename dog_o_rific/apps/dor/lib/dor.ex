defmodule Dor do
  @moduledoc """
    DOR - Dog-O-Rific
    API for DOR application to get breeds and CURD favorites

  """

  @doc """
  get_breeds/1 returns a breed by id or all breeds if no argument is passed
  ## Examples

      iex> is_list(Dor.get_breeds())
      true

  """
  def get_breeds(id \\ nil) do
    Dor.Breeds.get(id)
  end

  @doc """
  get_favorites/1 returns a favorite by id or all favorites if no argument is passed
  ## Examples

      iex> is_list(Dor.get_favorites())
      true

  """
  def get_favorites(id \\ nil) do
    Dor.Favorites.get(id)
  end

  @doc """
  add_favorite/1 takes an breed_id as integer and returns :ok or {:error, reason}
  ## Examples

      iex> Dor.add_favorite(1)
      :ok


  """
  def add_favorite(id) do
    try do
      {:ok, _breed} = Dor.Breeds.get(id)
      :ok = Dor.Favorites.add(id)
      :ok
    rescue
      error -> {:error, "couldn't add favorite, reason: #{inspect(error)}"}
    catch
      error -> {:error, "couldn't add favorite, reason: #{inspect(error)}"}
    end
  end

  @doc """
  delete_favorite/1 takes an id of favorite as integer and returns :ok or {:error, reason}
  ## Examples

      iex> _ = Dor.add_favorite(1)
      ...> [favorite] = Dor.get_favorites() |>
      ...> Enum.filter(fn fave -> fave["breed"]["id"] == 1 end)
      ...> Dor.delete_favorite(favorite["id"])
      :ok

  """
  def delete_favorite(id) do
    Dor.Favorites.delete(id)
  end

end
