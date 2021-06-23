defmodule Blog.PostsFixture do
  alias Blog.Posts

  defmacro __using__([]) do
    quote do
      @valid_attrs %{content: "some content", title: "some title"}
      @update_attrs %{content: "some updated content", title: "some updated title"}
      @invalid_attrs %{content: nil, title: nil}

      def post_fixture(attrs \\ %{}) do
        {:ok, post} =
          attrs
          |> Enum.into(@valid_attrs)
          |> Posts.create_post()

        post
      end
    end
  end
end
