# rubocop:disable Style/SymbolArray
class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = Vote.all
  end

  def show; end

  def new
    @vote = Vote.new
  end

  def edit; end

  def create
    current_user = session[:current_user]
    if Vote.where(user_id: current_user).empty?
      @vote = Vote.new(vote_params)
      @vote.user_id = current_user
      if @vote.save
        redirect_to article_path(@vote.article_id), notice: 'Vote was successfully created.'
      else
        render :new
      end
    else
      update
    end
  end

  def update
    @vote = Vote.find_by(user_id: session[:current_user])
    if @vote.update(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    article_id = @vote.article_id
    @vote.destroy
    redirect_to article_path(article_id), notice: 'Vote was successfully destroyed.'
  end

  private

  def set_vote
    @vote = Vote.find_by(user_id: session[:current_user])
  end

  def vote_params
    params.permit(:article_id)
  end
end
# rubocop:enable Style/SymbolArray
