class UsersController < ApplicationController

before_filter :cors_preflight_check
after_filter :cors_set_access_control_headers

# For all responses in this controller, return the CORS access control headers.

def cors_set_access_control_headers
  headers['Access-Control-Allow-Origin'] = '*'
  headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  headers['Access-Control-Request-Method'] = '*'
  headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
end

# If this is a preflight OPTIONS request, then short-circuit the
# request, return only the necessary headers and return an empty
# text/plain.

def cors_preflight_check
  if request.method == :options
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Max-Age'] = '1728000'
    render :text => '', :content_type => 'text/plain'
  end
end

  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     APIKey.create(user_id: @user.id)
  #     session[:user_id] = @user.id
  #     redirect_to root_url
  #   else
  #     render "new"
  #   end
  # end

  # private
  # def user_params
  #   params.require(:user).permit(:email, :password, :password_confirmation)
  # end

  respond_to :html, :json, :js

  def index
    @users = User.all
    respond_with @users
  end

  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      APIKey.create(user_id: @user.id)
    end
    respond_with @user
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
