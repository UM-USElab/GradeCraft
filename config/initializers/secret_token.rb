# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
GradeCraft::Application.config.secret_key_base = ENV['SECRET']
GradeCraft::Application.config.secret_token = '26d85ffb4de7eb242758d39e3f98c0aa'