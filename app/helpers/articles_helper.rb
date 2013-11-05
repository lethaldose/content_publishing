module ArticlesHelper

  def display_content_text content
    "#{content[0..100]} ...." if content
  end
end
