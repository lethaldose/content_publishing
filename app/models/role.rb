class Role < ActiveRecord::Base
  attr_accessible :name
  has_many :users

  ROLES = ['admin','reporter','editor']

  validates :name, inclusion: { in: ROLES } , presence: true

  def is_admin?
    role? :admin
  end

  def is_editor?
    role? :editor
  end

  def is_reporter?
     role? :reporter
  end

  def role? role_name
    return unless self.name
    self.name.to_sym == role_name.to_sym
  end
end
