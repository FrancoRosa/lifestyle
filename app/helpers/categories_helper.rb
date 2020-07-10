module CategoriesHelper
  def session_votes(article)
    return if session[:current_user].nil?

    vote = article.votes.byuser(session[:current_user])
    if vote.empty?
      link_to('<i class="far fa-thumbs-up"></i>'.html_safe,
              votes_path(article_id: article.id), method: :post, class: 'text-grey')
    else
      if vote[0].article_id == article.id
        link_to('<i class="far fa-thumbs-down"></i>'.html_safe,
                vote_path(vote[0].id), method: :delete, class: 'text-orange')
      else
        link_to('<i class="far fa-thumbs-up"></i>'.html_safe,
                votes_path(article_id: article.id), method: :post, class: 'text-grey')
      end
    end
  end

  def session_edit_destroy(article)
    return unless article.author_id == session[:current_user]

    content_tag(:span, ' | ', class: 'text-grey') +
      content_tag(:span, link_to('Edit', edit_article_path(article), class: 'text-grey')) +
      content_tag(:span, ' | ', class: 'text-grey') +
      content_tag(:span, link_to('Destroy', article, method: :delete,
                                                     data: { confirm: 'Are you sure?' }, class: 'text-orange'))
  end

  def row_selector(article, index)
    if ((index / 2) % 2).zero?
      content_tag(:div, image_tag(article.image), class: 'article-image') +
        content_tag(:div, render(partial: 'article_text', locals: { article: article }), class: 'article-text')
    else
      content_tag(:div, render(partial: 'article_text', locals: { article: article }), class: 'article-text') +
        content_tag(:div, image_tag(article.image), class: 'article-image')
    end
  end
end
