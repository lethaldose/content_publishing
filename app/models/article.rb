class Article < ActiveRecord::Base
  include ActiveModel::Validations
  include ::ArticleState

  attr_accessible :name, :content
  attr_accessible :state

  validates :name, uniqueness: {case_sensitive: false}, presence: true
  validates :state, inclusion: { in: VALID_STATES } , presence: true


  after_initialize :init

  def init
    self.state = DRAFT if self.new_record?
  end

end

