class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end


  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

def map
  results = Geocoder.search(params[:address])
  @latlng = results.first.coordinates
  # これでmap.js.erbで、経度緯度情報が入った@latlngを使える。

  respond_to do |format|
    format.js
  end
end

  private
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def zipedit
      params.require(:user).permit(:postcode, :prefecture_name, :address_city, :address_street, :address_building)
    end

    def screen_user
      unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
      end
    end

end