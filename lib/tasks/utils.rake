# frozen_string_literal: true

namespace :utils do
  desc 'Cria Administradores Faker.'
  task generate_admins: :environment do
    puts 'Loading: Creating generic administrators...'
    5.times do |_administrators|
      Admin.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: '123456',
        password_confirmation: '123456',
        role: [0, 1, 1].sample
      )
    end
    puts 'Successfully: Administrators generic created!'
  end
end
