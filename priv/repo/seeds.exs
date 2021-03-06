# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Blog.Repo.insert!(%Blog.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Blog.Repo
alias Blog.Posts
alias Blog.Posts.Post

Repo.delete_all(Post)

if Mix.env() == :dev do
  Posts.create_post(%{title: Faker.Lorem.sentence(5), content: Faker.Lorem.paragraph(5)})
end

if Mix.env() == :test do
  # Posts.create_post(%{title: Faker.Lorem.sentence(4..10), content: Faker.Lorem.paragraph(1)})
  IO.puts("BLOCKING SEED FILE FOR TEST ENVIRONMENT TO AVOID FAILING TESTS")
end
