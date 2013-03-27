RSpec::Matchers.define :permit_policy do |user, record, action|
  match do |policy|
    policy.new(user, record).public_send(action)
  end

  failure_message_for_should do |policy|
    "Expected #{ policy.to_s } to permit #{ action.to_s } but it didn't"
  end

  failure_message_for_should_not do |policy|
    "Expected #{ policy.to_s } to forbid #{ action.to_s } but it didn't."
  end

  description do |policy|
    "permit #{action.to_s}"
  end
end
