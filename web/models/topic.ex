defmodule Discuss.Topic do 
    use Discuss.Web, :model

    schema "topics" do
        field :title, :string 
        belongs_to :user, Discuss.User 
        has_many :comments, Discuss.Comment
    end

    def changeset(struct, params \\ %{}) do # \\ is how you set something to default. 
        struct #struct is a hash but really think of it as an object
        |> cast(params, [:title]) #cast produces a changeset which is an object that records the db: params is what a struct needs to be 
        |> validate_required([:title]) #validator inspects properties of the changesets and says whether they are valid or not. 
    end #change set is both a function and an object. 
end 

