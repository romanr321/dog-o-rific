defmodule DorTest do
  use ExUnit.Case
  doctest Dor


  test "get breeds" do
    assert is_list(Dor.get_breeds()) == true
    {:ok, %{"name" => name}} = Dor.get_breeds(14)
    assert name == "Siberian Husky"
  end

  # using inspect/1 inside tests to force correct behaviour, could have used setup test section instead
  test "delete, add, get, delete a favorite" do
    # insert invalid breed
    {error, _} = Dor.add_favorite(-1)
    assert error == :error

    # delete breed 1 from favorites if exists
    favorites_list = Dor.get_favorites()
    with [favorite] <- Enum.filter(favorites_list, fn fave -> fave["breed"]["id"] == 1 end)
    do
      _ = Dor.delete_favorite(favorite["id"])
    end

    # add breed 1 to favorites
    assert Dor.add_favorite(1) == :ok

    # try to add breed 1 to favorites again, duplicates not allowed
    {error, _} = Dor.add_favorite(1)
    assert error == :error

    # get list of favorites
    favorites_list = Dor.get_favorites()

    # delete breed 1 from favorites
    [favorite] = Enum.filter(favorites_list, fn fave -> fave["breed"]["id"] == 1 end)
    assert is_list(favorites_list) == true
    assert Dor.delete_favorite(favorite["id"]) == :ok

    # try to delete an invalid favorite id
    IO.inspect(favorite["id"])
    {error, _} = Dor.get_favorites(favorite["id"])
    assert error == :error
  end
end
