module Types
  class QueryType < Types::BaseObject
    # `all_users` is automatically camelcased to `allUsers`
    field :users, [UserType], null: false

    # this method is invoked, when `all_link` fields is being resolved
    def users
      User.all
    end
  end
end
