defmodule PeepBlogBackend.Router do
  use PeepBlogBackend.Web, :router
  require PhoenixTokenAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugCors, [origins: ["http://localhost:3000"]]
  end

  pipeline :authenticated do
    plug PhoenixTokenAuth.Plug
  end

  scope "/", PeepBlogBackend do
    pipe_through :api
    PhoenixTokenAuth.mount

    # resources "/users", UserController
  end

  scope "/", PeepBlogBackend do
    pipe_through :api
    pipe_through :authenticated

    resources "/posts", PostController
    options "/posts*anything", PostController, :options
  end
end
