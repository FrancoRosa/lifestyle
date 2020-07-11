module ArticlesHelper
  def featured_article
    if @featured_id.empty?
      render 'def_article'
    else
      render 'top_article'
    end
  end

  def latest_article(category)
    if category.articles.count.positive?
      article = category.articles.latest
      render partial: 'top_category', locals: { category: category, article: article }
    else
      render partial: 'def_category', locals: { category: category }
    end
  end
end
