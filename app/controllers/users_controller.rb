# rubocop:disable Style/SymbolArray
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:name)
  end
end
# rubocop:enable Style/SymbolArray
