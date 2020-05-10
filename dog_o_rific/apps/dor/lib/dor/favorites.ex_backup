defmodule Dor.Favorites do
  use GenServer

  @file_path "./apps/dor/priv/favorites.bin"

    @moduledoc """
    Favorites process is a cache for favorites which keeps a all favorites in
    state for faster access and writes all new favorites to disk or database.

    Naieve implementation keeps a map of favorite_id and breed objects and writes
    them it as term_to_binary to disk on add/delete. The down side is that if a breed
    object was to change there would be data inconsistency, but since the breeds list is not
    updatable it is okay to have duplicate data stored. Duplicate data provides faster access
    at the cost of more complex control over consistency.
    The module also generates the next id which would usually be done by the database.

    If I had more time:
     - I would use a database. SQL or NoSQL
     - I could create two tables in SQL, one for breeds and another for favorites with a foreign key to breeds recid.
     - I could store all objects in NoSQL and use application logic to guarantee data consistency as in naieve implementation.

  """

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    # read all favorites from file on restart and caches them
    with {:ok, favorites_bin} <- File.read("./apps/dor/priv/favorites.bin"),
        favorites <- :erlang.binary_to_term(favorites_bin),
        max_id <- get_id(favorites)
    do {:ok, {favorites, max_id + 1}}
    else
      _error -> File.write("./apps/dor/priv/favorites.bin", :erlang.term_to_binary(%{}))
      {:ok, {%{}, 1}}
    end
  end

  def get_id(favorites) when favorites == %{} do
    0
  end

  def get_id(favorites) do
    Enum.reduce(Map.keys(favorites), fn x, acc -> max(x, acc) end)
  end

  def get(nil) do
    GenServer.call(__MODULE__, {:get, nil})
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def add(breed_id) when is_integer(breed_id) do
    GenServer.call(__MODULE__, {:add, breed_id})
  end

  def delete(id) when is_integer(id) do
    GenServer.cast(__MODULE__, {:delete, id})
  end

  def handle_call({:get, nil}, _, {favorites, _} = state) do
    {:reply, Map.values(favorites), state}
  end

  def handle_call({:get, id}, _, {favorites, _} = state) do
    {:reply, Map.fetch(favorites, id), state}
  end

  def handle_call({:add, breed_id}, _, {favorites, next_id} = state) do
    with {:ok, breed} <- Dor.Breeds.get(breed_id),
        false <- Enum.any?(favorites, fn {_, b} -> b["breed"] == breed end),
        favorites <- Map.put(favorites, next_id, %{"id" => next_id, "breed" => breed}),
        next_id <- next_id + 1
    do
      File.write(@file_path, :erlang.term_to_binary(favorites))
      {:reply, :ok, {favorites, next_id}}
    else
      error -> {:reply, {:error, "breed already in favorites"}, state}
    end
  end

  def handle_cast({:delete, id}, {favorites, next_id} = state) do
    favorites = Map.delete(favorites, id)
    File.write(@file_path, :erlang.term_to_binary(favorites))
    {:noreply, {favorites, next_id}}
  end

  # def handle_call(msg, from, state) do
  #   {:reply, :reply, state}
  # end

  # def handle_cast(msg, state) do
  #   {:noreply, state}
  # end

  # def handle_info(msg, state) do
  #   {:noreply, state}
  # end
end
