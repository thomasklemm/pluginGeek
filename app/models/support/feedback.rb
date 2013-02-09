class Support::Feedback
  include Virtus

  attribute :body, String
  attribute :user, Support::User
end
