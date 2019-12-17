require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  before :each do
    @user = User.create(
        first_name:  'Jon',
        last_name: 'Test',
        email: 'same@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
    )
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "User can click login, navigate to login page and login" do
    visit root_path
    click_on('Login')
    expect(page).to have_text('Email')
    save_screenshot('login_page.png')
    fill_in 'Email', with: "same@gmail.com"
    fill_in 'Password', with: "sfdka;kf;12321"
    click_on('Submit')
    expect(page).not_to have_text('Login')
    save_screenshot('logged_in.png')

  end
end
