class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    @categories = Category.all.order(:priority)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
    @categories = Category.all.order(:priority)
  end

  # GET /articles/1/edit
  def edit
    @categories = Category.all
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.author_id = session[:current_user] 
    if @article.save
      ArticlesCategory.new(article: @article, category_id: category_params[:id]).save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      @categories = Category.all
      render :new, alert: 'Article was not created.'
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if @article.update(article_params)
      ArticlesCategory.where(article_id: @article.id).first_or_create(category_id: category_params[:id])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, alert: 'Article was not updated.'
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :text, :image)
    end
    def category_params
      params.require(:category).permit(:id)
    end
end
