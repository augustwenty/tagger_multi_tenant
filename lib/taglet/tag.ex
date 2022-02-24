defmodule Tags_Multi_Tenant.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :name, :string, null: false

    has_many :taggings, Tags_Multi_Tenant.Tagging
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required(:name)
  end
end
