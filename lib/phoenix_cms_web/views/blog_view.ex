defmodule PhoenixCmsWeb.BlogView do
  use PhoenixCmsWeb, :view

  def format_date(post) do
    {:ok, relative_str} = Timex.format(post.inserted_at, "{relative}", :relative)
    relative_str
  end

  def post_excerpt(post) do
    String.slice(post.body, 0..120) <> "..."
  end

  def markdown(body) do
   body
   |> Earmark.as_html!(%Earmark.Options{smartypants: false})
   |> raw()
   end

end
