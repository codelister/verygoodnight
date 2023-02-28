class SleepRecordsController < ApplicationController
  def index
    @sleep_records = SleepRecord.where(user_id: params[:user_id]).select(params[:select]).order(created_at: :desc)
    render json: @sleep_records
  end

  def create
    @user = User.find(params[:user_id])
    @sleep_record = SleepRecord.new(sleep_time: params[:sleep_time], user_id: @user.id)
    if @sleep_record.save
      render json: @sleep_record
    else
      render json: @sleep_record.errors, status: :unprocessable_entity
    end
  end

  def update
    @sleep_record = SleepRecord.find(params[:id])
    if @sleep_record.update(wake_time: params[:wake_time])
      render json: @sleep_record
    else
      render json: @sleep_record.errors, status: :unprocessable_entity
    end
  end
end
