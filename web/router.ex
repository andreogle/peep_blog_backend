defmodule PeepBlogBackend.Router do
  use PeepBlogBackend.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug PlugCors, [origins: [System.get_env("FRONTEND_URL")]]
  end

  # scope "/", PeepBlogBackend do
  #   pipe_through :browser # Use the default browser stack
  #
  #   get "/", PageController, :index
  # end

  # Other scopes may use custom stacks.
  scope "/", PeepBlogBackend do
    pipe_through :api

    resources "/posts", PostController
    options "/posts*anything", PostController, :options
  end
end
