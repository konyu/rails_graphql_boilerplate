module Mutations
  class CreateUser < BaseMutation
    # arguments passed to the `resolved` method
    argument :email, String, required: true
    argument :password, String, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(email: nil, password: nil)
      User.create!(email: email, password: password)
    end
  end
end