class Article < ActiveRecord::Base
  include ActiveModel::Validations

  attr_accessible :name, :content

  validates :name, uniqueness: {case_sensitive: false}, presence: true
end

