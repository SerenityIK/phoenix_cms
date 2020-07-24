defmodule PhoenixCmsWeb.Uploaders.Cover do
  use Arc.Definition
  use Arc.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :thumb]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(version, _scope) do
    "/images/avatars/default_#{version}.png"
  end

end
