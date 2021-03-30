class UsersController < Clearance::UsersController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    not_found unless @user

    @experts = if params[:search]
                 User.search_by_website_excluding_user(params[:search], @user)
               else
                 []
               end
  end

  def edit
    @user = User.find(params[:id])
    not_found unless @user
  end

  def update
    @user = User.find(params[:id])
    not_found unless @user

    @user.friends << User.find(user_params[:friends].to_i)
    redirect_back_or @user
  end

  def new
    @user_signup = User::Signup.new
    render template: "users/new"
  end

  def create
    @user_signup = user_signup_from_params

    if @user_signup.save
      sign_in @user_signup
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  def user_signup_from_params
    email = user_signup_params.delete(:email)
    password = user_signup_params.delete(:password)

    User::Signup.new(user_signup_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def user_params
    params.require(:user).permit(:friends)
  end

  def user_signup_params
    logger.debug params.inspect
    params.require(:user_signup).permit(:email, :password, :website_url, :first_name, :last_name, :friends) || {}
  end
end
