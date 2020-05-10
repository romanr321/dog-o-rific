defmodule DorTest do
  use ExUnit.Case
  doctest Dor


  test "get breeds" do
    assert is_list(Dor.get_breeds()) == true
    {:ok, %{"name" => name}} = Dor.get_breeds(14)
    assert name == "Siberian Husky"
  end

  test "delete, add, get, delete a favorite" do
    assert Dor.add_favorite(-1) == {:error, "not found"}
    assert Dor.add_favorite(1) == :ok
    assert  {:error, _} == Dor.add_favorite(1)
    favorites_list = Dor.get_favorites()
    [favorite] = Enum.filter(favorites_list, fn fave -> fave["breed"]["id"] == 1 end)
    assert is_list(Dor.get_favorites()) == true
    assert Dor.delete_favorite(favorite["id"]) == :ok
    assert {:error, _} == Dor.get_favorites(favorite["id"])
  end
end
