module ArticleState
  DRAFT = :Draft
  PUBLISHED = :Published

  VALID_STATES = [DRAFT, PUBLISHED]

  def draft?
    self.state == DRAFT
  end

  def published?
    self.state == PUBLISHED
  end

  def publish
    self.state = PUBLISHED
  end
end
