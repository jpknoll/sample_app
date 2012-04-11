class UsersController < ApplicationController
  def new
  end
   rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to home_url
end
