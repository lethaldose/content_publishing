class HomeController < ApplicationController

  skip_before_filter :authenticate_user!

  def index
    if !user_signed_in?
      @published_articles = Article.published_articles
      render :guest_home
      return
    end

    @draft_articles_count = Article.draft_articles_count_for(current_user)
    @published_articles_count = Article.published_articles_count_for(current_user)
  end
end
