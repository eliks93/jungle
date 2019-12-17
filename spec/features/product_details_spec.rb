require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  before :each do
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
  scenario "User can click on a product and navigate to the product details page and see the products details" do
    visit root_path

    first('article.product').click_on('Details »')
    expect(page).to have_text('Quantity')
    save_screenshot('product_details.png')

  end

end
