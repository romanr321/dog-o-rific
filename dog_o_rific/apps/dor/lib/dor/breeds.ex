defmodule Dor.Breeds do
  use GenServer
    @moduledoc """
    Breeds process is a breeds cache which holds a list of breeds and a map
    for faster access to specific breed by id.

  """

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_) do
    # read from file/NoSQL DB and cache all dog breeds as jsonin a map/ets table kept in state
    with {:ok, breeds_json_list} <- File.read("./apps/dor/priv/breeds.json"),
        breeds_list <- breeds_json_list |> Jason.decode!(),
        breeds_map <- to_state_map(breeds_list)
    do {:ok, {breeds_list, breeds_map}}
    end
  end

  # init helper function, converts list of maps to map of maps with breed id as key
  defp to_state_map(breeds) do
    for b <- breeds, into: %{}, do: {b["id"], b}
  end

  def get(nil) do
    GenServer.call(__MODULE__, {:get, nil})
  end

  def get(id) do
    GenServer.call(__MODULE__, {:get, id})
  end

  def handle_call({:get, nil}, _, {list, _} = state) do
    {:reply, list, state}
  end

  def handle_call({:get, id}, _, {_, breed_map} = state) do
    with {:ok, breed} <- Map.fetch(breed_map, id)
    do
      {:reply, {:ok, breed}, state}
    else
      error -> {:reply, {:error, error}, state}
    end
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
