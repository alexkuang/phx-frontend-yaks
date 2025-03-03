defmodule BlogDemoReactWeb.CommentFeedChannel do
  use Phoenix.Channel

  alias BlogDemoReact

  def join("post:" <> post_id, _params, socket) do
    case BlogDemoReact.get_post(post_id) do
      nil -> {:error, %{reason: "post does not exist"}}
      _post -> {:ok, socket}
    end
  end

  def handle_in("new_comment", %{"body" => body, "author" => author, "id" => id}, socket) do
    broadcast!(socket, "new_comment", %{body: body, author: author, id: id})
    {:noreply, socket}
  end
end
