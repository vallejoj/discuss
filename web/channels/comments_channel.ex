defmodule Discuss.CommentsChannel do
    use Discuss.Web, :channel
    alias Discuss.{Topic, Comment} #we do not want to have repititve alias statements so lets make one! 
    

    def join("comments:" <> topic_id, _params, socket) do #<> is how we join strings in ELixir
        topic_id = String.to_integer(topic_id)
        topic = Topic 
        |> Repo.get(topic_id)
        |> Repo.preload(comments: [:user]) # this line of code say go and find topic with this id and then go and find evey comment that has this topic id
            # above we find the given topic and then find the assoc that goes with it. 
        {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)} #changing this to assigns makes it so that any follow up function can get which topic we are using look up assigns when you have a chance. 
    end

    def handle_in(name, %{"content" => content}, socket) do #is about any follow up communication
        topic = socket.assigns.topic
        user_id = socket.assigns.user_id

        changeset = topic
        |> build_assoc(:comments, user_id: user_id) #used whenever we want to create a new record but it is only good for one assoc, second arguement is us building the assoc
        |> Comment.changeset(%{content: content})

        case Repo.insert(changeset) do 
        {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment}) # !this is so that if we know something goes wrong it get sent to us. 1st arguement is the socket 2nd arguement is the name of the event that gets sent out, 3rd is new data
        {:reply, :ok, socket}
        {:error, _reason} ->
            {:reply, {:error, %{errors: changeset}}, socket}
        end
    end
end