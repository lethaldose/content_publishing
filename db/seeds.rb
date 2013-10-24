# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#


['reporter', 'editor', 'admin'].each do |role|
  Role.find_or_create_by_name role
end

admin_role =  Role.find_by_name('admin')

if !User.find_by_email('admin@admin.com')
  admin_user = User.new(email:'admin@admin.com', password:'password', password_confirmation:'password')
  admin_user.role = admin_role
  admin_user.save!
end

Article.create(name: 'First')
