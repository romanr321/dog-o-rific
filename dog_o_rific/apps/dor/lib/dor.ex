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

      iex> Dor.add_favorite(-1)
      {:error, "breed id not found"}


  """
  def add_favorite(id) do
    with {:ok, breed} <- Dor.Breeds.get(id)
    do Dor.Favorites.add(id)
    else
      error -> {:error, "breed id not found"}
    end
  end

  @doc """
  delete_favorite/1 takes an id of favorite as integer and returns :ok or {:error, reason}
  ## Examples

      iex> Dor.delete_favorite(0)
      :ok

  """
  def delete_favorite(id) do
    Dor.Favorites.delete(id)
  end

end
