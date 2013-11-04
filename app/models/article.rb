class Article < ActiveRecord::Base
  include ActiveModel::Validations
  include ::ArticleState

  attr_accessible :name, :content
  attr_accessible :state

  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :state, inclusion: { in: VALID_STATES } , presence: true
  validates :author, presence: true

  belongs_to :author, class_name: User.name

  after_initialize :init

  def init
    self.state = DRAFT if self.new_record?
  end

end

