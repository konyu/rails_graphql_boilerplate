module Mutations
  class SignUp < BaseMutation
    # arguments passed to the `resolved` method
    argument :email, String, required: true
    argument :password, String, required: true

    # return type from the mutation
    type Types::UserType

		def resolve(email: nil, password: nil)
      user = User.new(email: email, password: password)
      # validation error
      if user.save
        { user: user }
      else
        # error response sample
        # {
        #   "data": null,
        #   "errors": [
        #     {
        #       "message": "Email has already been taken",
        #       "locations": [
        #         {
        #           "line": 2,
        #           "column": 2
        #         }
        #       ],
        #       "path": [
        #         "signUp"
        #       ]
        #     }
        #   ]
        # }
        raise GraphQL::ExecutionError, user.errors.full_messages.join(", ")
      end
    end
  end
end