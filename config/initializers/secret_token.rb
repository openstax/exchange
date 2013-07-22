# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
Exchange::Application.config.secret_token = 
  SECRET_SETTINGS[:secret_token] || 'ed7592e5ab5aec106af2aee88b5466f1df3a625d6aaad7b83f4b28b5a098b796580e967ad4277dca6738a46436546f7c90b391ebd24b820c3224e589698954b8'
