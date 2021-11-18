class UserProfilesController < ApplicationController
  def show
    @user_profile = UserProfile.find(params[:id])
  end

  def new
    @user_profile = UserProfile.new
  end

  def create
    @user_profile = current_user.build_user_profile(user_profile_params)
    if @user_profile.save
      redirect_to @user_profile, success: t('.success')
    else
      render :new
    end
  end

  private

  def user_profile_params
    params.require(:user_profile).permit(:full_name, :social_name, :birth_date, :cpf, :zipcode, :address_line_one,
                                         :address_line_two, :city, :state, :country)
  end
end
