class HomeController < ApplicationController
  def index
    @draft_articles_count = Article.where({state:ArticleState::DRAFT}).count
    @published_articles_count = Article.where({state:ArticleState::PUBLISHED}).count
  end
end
