class GoalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @goals = @user.goals
  end

  def show
    @goal = Goal.find(params[:id])
  end
  def new
    @user = current_user
    @goal = Goal.new
  end

  def create
    @user = current_user
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:notice] = "You saved #{@goal.name}"
      redirect_to user_goals_path(current_user)
    else
      flash[:alert] = @goal.errors.full_messages.each {|m| m.to_s}.join
      render :new
    end
  end

  def edit
    @user = current_user
    @goal = Goal.find(params[:id])
  end

  def update
    @user = current_user
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      flash[:notice] = "You edited #{@goal.name}"
      redirect_to user_goals_path(current_user)
    else
      flash[:alert] = @goal.errors.full_messages.each {|m| m.to_s}.join
      render :edit
    end
  end

  def destroy
    @user = current_user
    @goal = Goal.find(params[:id])
    @goal.destroy
    flash[:notice] = "You deleted #{@goal.name}"
    redirect_to user_goals_path(current_user)
  end

  private

  def goal_params
    params.require(:goal).permit(:start_location, :end_location, :total_distance, :name)
  end
end