defmodule Blog.Factory do
  # with Ecto
  use ExMachina.Ecto, repo: Blog.Repo
  alias Blog.Posts.Post

  def post_factory do
    %Post{
      title: sequence("Example Title"),
      content: sequence(:content, [long_content(), medium_content(), short_content()])
    }
  end

  def long_content do
    Faker.Lorem.paragraphs(5) |> Enum.join("\n")
  end

  def medium_content do
    Faker.Lorem.paragraph(5)
  end

  def short_content do
    Faker.Lorem.sentence(5)
  end

  # derived factory
  def long_post_factory do
    struct!(
      post_factory(),
      %{
        content: Faker.Lorem.paragraphs(5..10) |> Enum.join("\n")
      }
    )
  end
end
