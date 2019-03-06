# frozen_string_literal: true

namespace :utils do
  desc 'Cria Administradores Faker.'
  task generate_admins: :environment do
    puts 'Loading: Creating administrator ...'
    5.times do |_administrators|
      Admin.create!(email: Faker::Internet.email,
                    password: '123456',
                    password_confirmation: '123456')
    end
    puts 'Successfully: Administrator created.'
  end
end
