# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

admin = User.new(
  email: 'shu915.web.creation@gmail.com',
  tel: '07010607847',
  birthday: '1987-09-15',
  password: ENV['ADMIN_PASSWORD']
)
admin.skip_confirmation!
admin.save
