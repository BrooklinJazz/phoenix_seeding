defmodule Blog.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Accounts.Author

  schema "posts" do
    field :content, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content])
    |> validate_required([:title, :content])
  end
end
