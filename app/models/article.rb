class Article < ActiveRecord::Base
  include ActiveModel::Validations
  include ::ArticleState

  SORT_BY_UPDATED_AT_DESC = 'updated_at desc'

  attr_accessible :name, :content
  attr_accessible :state

  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :state, inclusion: { in: VALID_STATES } , presence: true
  validates :author, presence: true

  belongs_to :author, class_name: User.name

  after_initialize :init

  scope :all_for_author, ->(author) { where(author_id: author).order(SORT_BY_UPDATED_AT_DESC) }
  scope :published_articles, -> { where(state: ArticleState::PUBLISHED) }

  def init
    self.state = DRAFT if self.new_record?
  end

  def self.editable_by user
    (user.is_editor? or user.is_admin?) ? Article.order(SORT_BY_UPDATED_AT_DESC) : Article.all_for_author(user)
  end

  def self.draft_articles_count_for author
    self.count_by_state author, ArticleState::DRAFT
  end

  def self.published_articles_count_for author
    self.count_by_state author, ArticleState::PUBLISHED
  end

  private

  def self.count_by_state author, state
    if author.is_editor? or author.is_admin?
      Article.where({state:state}).count
    else
      Article.where(author_id: author).where({state:state}).count
    end
  end
end

