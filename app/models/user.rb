class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  belongs_to :role
  has_many :articles, foreign_key: :author_id
  before_create :set_default_role


  def is_admin?
    self.role.name == 'admin'
  end

  private

  def set_default_role
    self.role ||= Role.find_by_name('reporter')
  end

end
