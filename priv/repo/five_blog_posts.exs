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
alias Faker.Lorem

for _ <- 1..5 do
  Posts.create_post(%{title: Lorem.sentence(4..12), content: Lorem.paragraphs(4..20) |> Enum.join("\n")})
end
