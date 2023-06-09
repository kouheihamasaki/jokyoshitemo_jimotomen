class Admin::UsersController < ApplicationController


  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "正常に更新されました。"
    else
      render :edit
    end
  end


 private


  def user_params
    params.require(:user).permit(:last_name,:first_name,
                                     :last_name_kana,:first_name_kana,
                                     :introduction,:prefecture,:screen_name,
                                     :fav_noodle,:email,:is_deleted)
  end


end