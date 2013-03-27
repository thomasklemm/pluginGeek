RSpec::Matchers.define :authorize_resource do
  match do
    assigns(:_policy_authorized) == true
  end

  failure_message_for_should do
    "Expected controller action to call 'authorize @resource' but it didn't."
  end

  failure_message_for_should_not do
    "You really want to check for 'should_not authorize_resource'? You might want to check for 'should authorize_resource' instead."
  end

  description do
    "authorize resource"
  end
end
