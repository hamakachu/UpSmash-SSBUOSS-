module ArticlesHelper
  def markdown_to_html(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text).html_safe
  end
end
