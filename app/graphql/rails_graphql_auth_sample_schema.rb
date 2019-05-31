class RailsGraphqlAuthSampleSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # catch validation errors and response error json
  # {
  #   "data": null,
  #   "errors": [
  #     {
  #       "message": "Validation failed: Email has already been taken",
  #       "locations": [
  #         {
  #           "line": 2,
  #           "column": 2
  #         }
  #       ],
  #       "path": [
  #         "signUp"
  #       ],
  #       "extensions": {
  #         "code": "VALIDATION_ERROR",
  #         "problems": "Email has already been taken"
  #       }
  #     }
  #   ]
  # }
  rescue_from ActiveRecord::RecordInvalid do |error|
    raise GraphQL::ExecutionError.new(
      error.message,
      extensions: {
        code: 'VALIDATION_ERROR',
        problems: error.record.errors.full_messages.join(", ")
      }
    )
  end
end
