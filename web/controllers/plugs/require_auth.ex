defmodule Discuss.Plugs.RequireAuth do
    import Plug.Conn #gives us halt function
    import Phoenix.Controller #gives us redirect and put flash

    alias Discuss.Router.Helpers

    def init(_params) do    
    end

    def call(conn, _params) do #params is whatever is returned from init function, right now that is nothing
        if conn.assigns[:user] do
            conn #everything went great continue on do what you want. lesson 110
        else
            conn
            |> put_flash(:error, "You must be logged in")
            |> redirect(to: Helpers.topic_path(conn, :index)) #we are using helpers here because we dont have a Usecall, check controllers to see a use call Discuss.web
            |> halt() #we are using a halt here because phx wants to continue sending stuff to the controller.
        end
    end
end