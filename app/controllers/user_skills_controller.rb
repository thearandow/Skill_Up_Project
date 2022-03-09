class UserSkillsController < ApplicationController
  skip_before_action :authenticate_user!, only: :show

  def show
    @user_skill = UserSkill.find(params[:id])
    authorize @user_skill
    @booking = Booking.new
    @reviews = Review.where(@booking.teacher)

  end

  def create
    @user_skill = UserSkill.new
    @skill = Skill.find(params[:user_skill][:skill].to_i)
    @user_skill.skill = @skill
    @user_skill.user = current_user
    @user_skill.description = params[:user_skill][:description]
    authorize @user_skill
    if @user_skill.save!
      redirect_to dashboard_path
    else
      render
    end
  end

  def edit
    @user_skill = UserSkill.find(params[:id])
  end

  def update
    @user_skill = UserSkill.find(params[:id])
    @user_skill.description = params[:description] || params[:user_skill][:description]
    @user_skill.save
    authorize @user_skill
    if @user_skill.save!
      redirect_to dashboard_path
    else
      render
    end
  end

  def destroy
    @user_skill = UserSkill.find(params[:id])
    @user_skill.destroy
    authorize @user_skill
    redirect_to dashboard_path
  end

  private

  def params_user_skill
    params.require(:user_skill).permit(:name, :skill, :description, :id)
  end
end
