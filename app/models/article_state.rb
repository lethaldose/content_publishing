module ArticleState
  DRAFT = :Draft.to_s
  PUBLISHED = :Published.to_s

  VALID_STATES = [DRAFT, PUBLISHED]

  def self.included(base)
    base.class_eval do
      before_save :disallow_published_article_update
    end
  end

  def draft?
    self.state == DRAFT
  end

  def published?
    self.state == PUBLISHED
  end

  def publish! user
    self.state = PUBLISHED
    self.publisher = user
    self.save!
  end

  def disallow_published_article_update
    if self.persisted? && Article.find(self.id).published?
      errors.add(:state, "cannot update published articles")
      return false
    end

    true
  end
end
