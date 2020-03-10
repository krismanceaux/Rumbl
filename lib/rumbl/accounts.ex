defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts Context.
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users do
    Repo.all(User)

    # this commented-out stuff was used before setting up the repo
    # [
    #   %User{id: "1", name: "Jose", username: "josevalim"},
    #   %User{id: "2", name: "Bruce", username: "redrapids"},
    #   %User{id: "3", name: "Chris", username: "chrismccord"}
    # ]
  end

  def get_user(id) do
    Repo.get(User, id)
    # this commented-out stuff was used before setting up the repo
    # Enum.find(list_users(), fn map -> map.id == id end)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
    # this commented-out stuff was used before setting up the repo
    # Enum.find(list_users(), fn map ->
    #   Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    # end)
  end

  # this just returns an empty changeset to use with the form
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # just returns an empty changeset to use with the form
  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    user = get_user_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
