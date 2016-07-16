class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pads = @user.pads
  end
end
