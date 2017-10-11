defmodule Discuss.UserSocket do
  use Phoenix.Socket


  channel "comments:*", Discuss.CommentsChannel # :* means wildcard, this channel can also be thought of as a route

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do #whenever a new js client connects to our phoinix server with a websocket
    {:ok, socket}
  end

 
  def id(_socket), do: nil
end

#in a phx app we have different channels, for this app we are going to have one channel, there will one channel for all the comments
