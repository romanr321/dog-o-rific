defmodule Dor.NewFavorite do
  use Ecto.Schema

  @schema_prefix "main"
  @primary_key {:id, :id, autogenerate: true}

  schema "favorites" do
    field :breed_id, :integer
  end
end

defmodule Dor.Favorite do
  use Ecto.Schema

  @schema_prefix "main"
  @primary_key {:id, :id, autogenerate: true}

  schema "v_favorites" do
    field :breed, :binary
  end
end


defmodule Dor.Breed do
  use Ecto.Schema

  @schema_prefix "main"
  @primary_key {:id, :id, []}

  schema "breeds" do
    field :breed, :binary
  end

end
