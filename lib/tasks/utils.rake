# frozen_string_literal: true

namespace :utils do
  desc 'Create Administrator faker.'
  task generate_admins: :environment do
    puts 'Loading: Creating generic administrators...'
    10.times do |_administrators|
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

  desc 'Create Ads faker.'
  task generate_ads: :environment do
    puts 'Loading: Creating generic ads...'
    100.times do |_ads|
      Ads.create!(
        title: Faker::Lorem.sentece([2, 3, 4, 5].sample),
        text: Faker::Lorem.paragraph(Random.rand(3)),
        category: Category.all.sample,
        member: Member.all.sample
      )
    end
    puts 'Successfully: Ads generic created!'
  end
end
