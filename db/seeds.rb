# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveRecord::Base.transaction do
  puts "Initializing the App DB started..."
  sysadmin = Role.sysadmin
  admin = User.create(name:                 "CondoMan SystAdmin User", 
                     email:                 "condoman@mail.com", 
                     password:              "CondoMan", 
                     password_confirmation: "CondoMan",
                     activated:             true, 
                     activated_at:          Time.zone.now)
  puts "  User #{admin.id} was created as \'#{admin.name}\' and initial password -->CondoMan<--. "
  role = Role.create(authority:             sysadmin,
                     user_id:               admin.id,
                     since:                 "01/01/1900")
  puts "  He is the Sysadmin for the App"
  puts "...initializing Ended"
end