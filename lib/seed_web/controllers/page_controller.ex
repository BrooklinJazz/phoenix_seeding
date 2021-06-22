defmodule SeedWeb.PageController do
  use SeedWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
