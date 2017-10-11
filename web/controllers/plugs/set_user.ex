defmodule Discuss.Plugs.SetUser do
    import Plug.Conn #assign
    import Phoenix.Controller # get session

    alias Discuss.Repo
    alias Discuss.User
    

    def init(_params) do #this is all you have to do to create an init, next we have to make a call which is the two aspects to a module plug,
    end # if you ever had  alot of data you are going to push through you can work through more the init function, do reasearch on that on your own. 

    def call(conn, _params) do #params here is actually the return value of what come back from the init function. 
        user_id = get_session(conn, :user_id) 

        cond do
            user = user_id && Repo.get(User, user_id) ->
            assign(conn, :user, user)
            #conn.assigns.user => user struct #lectiure 106 if you need to review, 
            true -> 
                assign(conn, :user, nil)
        end
    end
end