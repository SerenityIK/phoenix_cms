defmodule PhoenixCmsWeb.Uploaders.Cover do
  use Arc.Definition
  use Arc.Ecto.Definition

  # To add a thumbnail version:
  @versions [:original, :thumb]

  # Whitelist file extensions:
  @extension_whitelist ~w(.jpg .jpeg .gif .png)

  def validate({file, _}) do
    file_extension = file.file_name |> Path.extname() |> String.downcase()
    Enum.member?(@extension_whitelist, file_extension)
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250"}
  end

  # Provide a default URL if there hasn't been a file uploaded
  def default_url(version, _scope) do
    "/images/covers/default_#{version}.jpg"
  end

end
