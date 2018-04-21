class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    user = User.find(current_user.id)
    user.nickname = params[:user][:nickname]
    user.owner_id = params[:user][:owner_id]
    user.save!
    redirect_to root_path, notice: 'ユーザー情報を変更しました'
  end
end