# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version
  ruby 3.2.0 (2022-12-25 revision a528908271) [x86_64-darwin22]

- Create an API:
  $ rails new cat-tinder-backend -d postgresql -T
  $ cd cat-tinder-backend
  $ rails db:create
  $ bundle add rspec-rails
  $ rails generate rspec:install
  $ git remote add origin https://github.com/TheUnforgettables/unforgettables-backend.git
  $ git branch -M main
  $ git push -u origin main -- If this does not work, youll need to do the following commands:
  $ git add .
  $ git commit -m "initial commit"
  $ git push origin main

- Devise
  $ bundle add devise
  $ rails generate devise:install
  $ rails generate devise User
  $ rails db:migrate

- JSON Web Token (JWT)
  add the following to our Gemfile:
    gem 'devise-jwt'
    gem 'rack-cors'

- CORS Setup
  create a new file in config/initializers named cors.rb
  Add the following code to that file:  
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins 'http://localhost:3001'
        resource '*',
        headers: ["Authorization"],
        expose: ["Authorization"],
        methods: [:get, :post, :put, :patch, :delete, :options, :head],
        max_age: 600
      end
    end


- Additional Devise Configurations
  Add the following code near the other mailer options within config/environments/development.rb  
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

- Instruct Devise to listen for logout requests via a get request instead of the default delete:
  We also want to prevent Devise from using flash messages which are not presented in Rails API mode. We can do both these things in the Devise configuration file within config/initializers/devise.rb:

- Create registrations and sessions controllers to handle signups and logins
  $ rails g devise:controllers users -c registrations sessions

- Then replace the contents of these controllers with the following code within app/controllers/users/registrations_controller.rb:
  class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json
  def create
    build_resource(sign_up_params)
    resource.save
    sign_in(resource_name, resource)
    render json: resource
  end
end

as well as within app/controllers/users/sessions_controller.rb:
  class Users::SessionsController < Devise::SessionsController
    respond_to :json
    private
    def respond_with(resource, _opts = {})
      render json: resource
    end
    def respond_to_on_destroy
      render json: { message: "Logged out." }
    end
  end

- Update the devise routes: config/routes.rb:
  Rails.application.routes.draw do
    resources :apartments
    devise_for :users,
      path: '',
      path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
      },
      controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  end

- JWT Secret Key Configuration

- Configure Devise and JWT
  Add the following code to the Devise configurations file within config/initializers/devise.rb:
  config.jwt do |jwt|
    jwt.secret = Rails.application.credentials.jwt_special_key
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}],
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
    jwt.expiration_time = 5.minutes.to_i
  end


- Revocation with JWT
  Use a DenyList to revoke the JWT. To create a DenyList, we need to generate a new model:
  $ rails generate model jwt_denylist











- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

- ...
