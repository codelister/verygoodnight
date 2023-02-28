class UserFollowsController < ApplicationController
  def followers
    # Return all the users that follow the user with the given id
    @user = User.find(params[:user_id])
    @user_follows = UserFollow.where(followee_id: @user.id)
    render json: @user_follows
  end

  def followees
    # Returns all the users that the user with the given id is following
    @user = User.find(params[:user_id])
    @user_follows = UserFollow.where(follower_id: @user.id)
    render json: @user_follows
  end

  def create
    @user = User.find(params[:user_id])
    @user_to_follow = User.find(params[:followee_id])
    @user_follow = UserFollow.new(follower_id: @user.id, followee_id: @user_to_follow.id)
    if @user_follow.save
      render json: @user_follow
    else
      render json: @user_follow.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user_follow = UserFollow.where(followee_id: params[:followee_id], follower_id: params[:user_id]).first
    @user_follow.destroy
    render json: @user_follow
  end
end
