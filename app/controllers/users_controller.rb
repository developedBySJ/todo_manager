class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.all.map { |user| user.to_pleasant_string }.join("\n")
  end

  def create
    name = params[:name]
    email = params[:email]
    password = params[:password]

    user = User.create!({
      name: name,
      email: email,
      password: password,
    })
    render plain: "Welcome, we created your profile with id #{user.id}"
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
