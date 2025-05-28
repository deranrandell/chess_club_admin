class MembersController < ApplicationController
  before_action :set_member, only: %i[ show edit update destroy ]

  def index
    @members = Member.order(:rank)
  end

  def show
  end

  def new
    @member = Member.new
  end

  def edit
  end

  def create
    @member = Member.new(member_params)

    # Auto assign rank and games_played
    max_rank = Member.maximum(:rank) || 0
    @member.rank = max_rank + 1
    @member.games_played = 0

    if @member.save
      redirect_to members_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @member.update(member_params)
      redirect_to members_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    deleted_rank = @member.rank

    ActiveRecord::Base.transaction do
      @member.destroy!
      Member.where("rank > ?", deleted_rank).update_all("rank = rank - 1")
  end
    redirect_to members_path
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email, :birthday)
  end
end
