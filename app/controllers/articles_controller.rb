# rubocop:disable Style/SymbolArray
class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = Article.all
    @categories = Category.top(4)
    @featured_id = Article.rank.map { |key, val| [val, key] }
    @featured = Article.find(@featured_id.max[1]) unless @featured_id.empty?
  end

  def show; end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

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

  def update
    if @article.update(article_params)
      ArticlesCategory.where(article_id: @article.id).first_or_create(category_id: category_params[:id])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit, alert: 'Article was not updated.'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_url, notice: 'Article was successfully destroyed.'
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text, :image)
  end

  def category_params
    params.require(:category).permit(:id)
  end
end
# rubocop:enable Style/SymbolArray
