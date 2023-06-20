module PostsHelper
  def format_date(date)
    date.strftime('%B %d, %Y')
  end
end
