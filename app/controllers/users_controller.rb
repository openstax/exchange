class UsersController < ApplicationController

  acts_as_interceptor

  skip_interceptor :require_registration!, only: [:registration, :register]

  fine_print_skip_signatures :general_terms_of_use, 
                             :privacy_policy, 
                             only: [:registration, :register]

  def registration
  end

  def register
    handle_with(UsersRegister,
                success: lambda { redirect_back },
                failure: lambda { render 'registration' })
  end
end
