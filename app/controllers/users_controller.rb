class UsersController < ApplicationController
  def index
  end

  def new
    # @user= User.new
  end

  def create
    # @user= User.new(user_param)
    #
    # if @user.save
    #
    #   redirect_to users_index_path
    #
    # else
    #   render 'new'
    # end
  end

  def download
    new_lecture = params[:attachment]
    send_file new_lecture

  end
  # def user_param
  #
  #   params.require(:user).permit(:name,:image,:email)
  # end
end
