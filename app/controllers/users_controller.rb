class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def new
    render "users/new"
  end

  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    password = params[:password]

    user = User.create!({
      first_name: first_name,
      last_name: last_name,
      email: email,
      password: password,
    })
    redirect_to "/"
  end

  def login
    email = params[:email]
    password = params[:password]

    user = User.find_by email: email
    render plain: user ? isValidPassword(password, user.password) : false
  end

  def isValidPassword(password, hashedPassword)
    password == hashedPassword
  end
end
