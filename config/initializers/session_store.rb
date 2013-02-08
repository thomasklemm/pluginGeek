# Be sure to restart your server when you modify this file.

# Use memcached via the dalli_store
Rails.application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 20.minutes
# Source: dalli readme

# Cookie-based session store
# Plugingeek::Application.config.session_store :cookie_store, key: '_plugingeek_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Plugingeek::Application.config.session_store :active_record_store
