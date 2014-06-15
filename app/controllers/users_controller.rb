class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @transactions = Transaction.all(params[:id])
  end
end
