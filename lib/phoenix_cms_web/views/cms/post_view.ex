defmodule PhoenixCmsWeb.Cms.PostView do
  use PhoenixCmsWeb, :view

  def publish_status(post) do
    case post.published do
      true -> "Yes"
      false > "No"
    end
  end

  def format_date(post) do
    {:ok, relative_str} = Timex.format(post.inserted_at, "{relative}", :relative)
    relative_str
  end

  def markdown(body) do
    body
    |> Earmark.as_html!(%Earmark.Options{smartypants: false})
    |> raw()
  end

end
