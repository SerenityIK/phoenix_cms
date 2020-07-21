defmodule PhoenixCmsWeb.Admin.BlogView do
  use PhoenixCmsWeb, :view

  def published_status(post) do
    case post.published do
      true -> "Yes"
      false -> "No"
    end
  end

end
