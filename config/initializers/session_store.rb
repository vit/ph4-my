# Be sure to restart your server when you modify this file.

#Rails.application.config.session_store :cookie_store, key: '_my_session'
Rails.application.config.session_store :cookie_store, :key => '_ipacs_session', :domain => "c9users.io"
