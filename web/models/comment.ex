defmodule Discuss.Comment do 
    use Discuss.Web, :model

    @derive {Poison.Encoder, only: [:content,:user]} #this is so that we are only sending the right type of data, if we dont do this then everythings falls apart becasue we are not sending proper data. 

    schema "comments" do
        field :content, :string 
        belongs_to :user, Discuss.User 
        belongs_to :topic, Discuss.Topic

        timestamps()
    end

    def changeset(struct, params \\ %{}) do # \\ is how you set something to default. 
        struct #struct is a hash but really think of it as an object
        |> cast(params, [:content]) #cast produces a changeset which is an object that records the db: params is what a struct needs to be 
        |> validate_required([:content]) #validator inspects properties of the changesets and says whether they are valid or not. 
    end #change set is both a function and an object. 
end 


