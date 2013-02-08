# Ensure the agent is started using Unicorn
# This is needed when using Unicorn and preload_app is NOT set to true.
# https://newrelic.com/docs/ruby/no-data-with-unicorn
NewRelic::Agent.after_fork(:force_reconnect => true) if defined? Unicorn
