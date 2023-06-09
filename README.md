# README

Minimal realisation app on Ruby on Rails API and framework Vue.js for OpenAI engine gpt-3.5-turbo.

Create file config/secret.yml  

development:
  openai_api_key: 'You api key'

test:
  openai_api_key: 'You api key'

production:
  openai_api_key: <%= ENV['OPENAI_API_KEY'] %>
