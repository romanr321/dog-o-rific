defmodule Dor.Breeds do
  alias Dor.Breed
    @moduledoc """
    Breeds process is a breeds cache which holds a list of breeds and a map
    for faster access to specific breed by id.

  """


  def populate() do
    # read from file and update database
     with {:ok, breeds_json_list} <- File.read("./apps/dor/priv/breeds.json"),
        breeds_list <- breeds_json_list |> Jason.decode!() |> Enum.map(fn breed -> %{:id => breed["id"], :breed => :erlang.term_to_binary(breed)} end)# |> Enum.map(fn breed -> struct(%Breed{}, bred) end)
    do Dor.Repo.insert_all(Breed, breeds_list,[])
    end
  end

  def get(nil) do
    try do
      breeds_recs = Dor.Repo.all(Breed)
      breeds = Enum.map(breeds_recs, fn breed_struct -> :erlang.binary_to_term(breed_struct.breed) end)
      breeds
    rescue
      error -> {:error, inspect(error)}
    catch
      error -> {:error, inspect(error)}
    end
  end

  def get(id) do
    try do
      breed_struct = Dor.Repo.get(Breed, id)
      case breed_struct == nil do
        true -> {:error, "not found"}
        _ -> breed = :erlang.binary_to_term(breed_struct.breed)
          {:ok, breed}
      end
    rescue
      error -> {:error, inspect(error)}
    catch
      error -> {:error, inspect(error)}
    end
  end

end
