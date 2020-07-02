class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    current_user = session[:current_user]
    if Vote.where(user_id: current_user).empty?
      @vote = Vote.new(vote_params)
      @vote.user_id = current_user
      if @vote.save
        redirect_to article_path(@vote.article_id), notice: 'Vote was successfully destroyed.'
      else
        render :new
      end
    else
      update
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    @vote = Vote.find_by(user_id: session[:current_user])
    if @vote.update(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    article_id = @vote.article_id
    @vote.destroy
    redirect_to article_path(article_id), notice: 'Vote was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find_by(user_id: session[:current_user])
    end

    # Only allow a list of trusted parameters through.
    def vote_params
      params.permit(:article_id)
    end
end
