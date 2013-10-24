require 'factory_girl'

FactoryGirl.define do

  sequence :email do |n|
    "foo#{n}@example.com"
  end

  sequence :article_name do |n|
    "Article #{n}"
  end

  factory :user, class: User do |u|
    u.email { FactoryGirl.generate(:email) }
    u.password "un_enc_password"
    u.password_confirmation "un_enc_password"
  end

  factory :article, class: Article do |u|
    u.name { FactoryGirl.generate(:name) }
    u.content "some content"
  end
end
