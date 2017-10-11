defmodule Discuss.User do
    use Discuss.Web, :model

    schema "users" do
        field :email, :string
        field :provider, :string
        field :token
        has_many :topics, Discuss.Topic
        has_many :comments, Discuss.Comment
        
        timestamps()
    end

    #changeset is how we turn a struct into something that can be inserted how we change a record

    def changeset(struct, params \\%{}) do
        struct
        |> cast(params, [:email, :provider, :token])
        |> validate_required([:email, :provider, :token])
    end
end