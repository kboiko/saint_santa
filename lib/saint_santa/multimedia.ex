defmodule SaintSanta.Multimedia do
  import Ecto.Query, warn: false
  alias SaintSanta.Repo

  alias SaintSanta.Multimedia.{Video, Category}
  alias SaintSanta.Accounts.User

  def list_videos, do: Repo.all(Video)

  def get__video!(id), do: Repo.get!(Video, id)

  def list_user_videos(%User{} = user) do
    Video
    |> user_videos_query(user)
    |> Repo.all()
  end

  def get_user_video!(%User{} = user, id) do
    Video
    |> user_videos_query(user)
    |> Repo.get!(id)
  end

  defp user_videos_query(query, %User{id: user_id}) do
    from(v in query, where: v.user_id == ^user_id)
  end

  def create_video(%User{} = user, attrs \\ %{}) do
    %Video{}
    |> Video.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def update_video(%Video{} = video, attrs) do
    video
    |> Video.changeset(attrs)
    |> Repo.update()
  end

  def delete_video(%Video{} = video) do
    Repo.delete(video)
  end

  def change_video(%Video{} = video, attrs \\ %{}) do
    Video.changeset(video, attrs)
  end

  def create_category!(name) do
    Repo.insert!(%Category{name: name}, on_conflict: :nothing)
  end

  def list_alphabetical_categories do
    Category
    |> Category.alphabetical()
    |> Repo.all()
  end
end
