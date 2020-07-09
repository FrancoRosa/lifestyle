module ApplicationHelper
  def path
    @path = request.env['PATH_INFO']
  end

  def show_notice
    render 'layouts/shownotice' if alert || notice
  end

  def color_selector(string)
    @path.include?(string) ? 'text-orange' : 'text-grey-light'
  end

  def session_links
    if session[:current_user].nil?
      render 'layouts/notlogged'
    else
      render 'layouts/logged'
    end
  end
end
