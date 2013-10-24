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

  def publish!
    self.state = PUBLISHED
    self.save!
  end

  def disallow_published_article_update
    errors.add(:state, "cannot update published articles")
    return false if self.persisted? && Article.find(self.id).published?
  end
end
