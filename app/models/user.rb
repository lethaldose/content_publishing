class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  belongs_to :role
  has_many :articles, foreign_key: :author_id
  has_many :published_articles, foreign_key: :publisher_id, class_name: Article.name

  before_create :set_default_role

  delegate :is_admin?, :is_reporter?, :is_editor?, to: :role

  def can_publish?
    is_admin? or is_editor?
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('reporter') if self.new_record?
  end

end
