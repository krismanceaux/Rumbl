defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts Context.
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users do
  Repo.all(User)
    # [
    #   %User{id: "1", name: "Jose", username: "josevalim"},
    #   %User{id: "2", name: "Bruce", username: "redrapids"},
    #   %User{id: "3", name: "Chris", username: "chrismccord"}
    # ]
  end

  def get_user(id) do
    Repo.get(User, id)
    #Enum.find(list_users(), fn map -> map.id == id end)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do 
    Repo.get_by(User, params)
    # Enum.find(list_users(), fn map ->
    #   Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    # end)
  end

end