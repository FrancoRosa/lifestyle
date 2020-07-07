# rubocop:disable Style/SymbolArray
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end
  
  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
      session[:current_user] = @user.id
      session[:current_user_name] = @user.name
    else
      render :new, alert: 'User was not created'
    end
  end

  def create_session
    @user = User.find_by(user_params)
    if @user.nil?
      redirect_to sign_in_path, alert: 'User not found, try again'
    else
      session[:current_user] = @user.id
      session[:current_user_name] = @user.name
      redirect_to root_path, notice: "Welcome #{@user.name}"
    end
  end

  def sign_in
    @user = User.new
  end

  def sign_out
    session[:current_user] = nil
    redirect_to root_path, alert: 'See you soon!'
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
# rubocop:enable Style/SymbolArray
