class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :upload_avatar, :drop_avatar]
  protect_from_forgery except: :user_widget
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def user_widget
    respond_to do |format|
        format.js
    end
  end
#  def find_by_email_password
  def remote_auth
#    p params
    op = params[:op]
    data = params['data'] || {}
    case op
    when 'authenticate_by_email'
#      p "authenticate_by_email"
      user = User.authenticate_by_email data['email'], data['password']
    when 'serialize_from_session'
#      p "serialize_from_session"
      #user = User.authenticate_by_session data['key'], data['salt']
      user = User.serialize_from_session data['key'], data['salt']
    when 'serialize_from_cookie'
#      p "serialize_from_cookie"
      user = User.serialize_from_cookie(*data['args'])
    when 'serialize_into_cookie'
#      p "serialize_into_cookie"
      result_array = User.serialize_into_cookie(User.find(data['id']))
    when 'remember_me!'
#      p "remember_me!"
      user = User.find(data['id'])
      user.remember_me!
      remember_data = {
        remember_token: user.respond_to?(:remember_token) ? user.remember_token : nil,
        remember_created_at: user.remember_created_at
      }
    when 'forget_me!'
#      p "forget_me!"
      user = User.find(data['id'])
      user.forget_me!
      #remember_data = {
      #}
    end
#    puts user.inspect
    respond_to do |format|
#        format.js
#        format.json { render json: {sid: @user.sid, full_name: @user.full_name, url: u_url(@user)}}
        format.json { render json: {
          user_data: user ? {
            id: user.id,
            email: user.email,
            fname: user.fname,
            mname: user.mname,
            lname: user.lname,
            salt: user.encrypted_password[0,29],
            avatar_url: request.base_url + user.avatar_url
          } : nil,
          result_array: result_array ? result_array : nil,
          remember_data: remember_data ? remember_data : nil
        }}
    end
  end


  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
        format.html { render :show }
        format.json { render json: {sid: @user.sid, full_name: @user.full_name, url: u_url(@user)}}
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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

  def upload_avatar
#    current_user.remove_avatar!
    current_user.avatar = params[:user][:avatar] # Assign a file like this, or
    current_user.save!
    @user.reload
    respond_to do |format|
      #format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.js
    end
  end
  def drop_avatar
#    puts "!!!!!!!!!"
#    puts params
    current_user.remove_avatar!
    @user.reload
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:show)
    end
end
