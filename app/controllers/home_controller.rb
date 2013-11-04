class HomeController < ApplicationController
  def index
    @draft_articles_count = Article.draft_articles_count_for(current_user)
    @published_articles_count = Article.published_articles_count_for(current_user)
  end
end
