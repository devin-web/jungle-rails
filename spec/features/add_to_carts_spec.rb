require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
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

  scenario "They see all products and click on one to add it to cart" do
    # ACT
    visit root_path

     # DEBUG / VERIFY
    #save_screenshot

    #block
    expect(page).to have_css 'article.product', count: 10

    product_cart_btn = page.first( 'a.btn.btn-primary' )

    expect(page).to have_css('#navbar', text: " My Cart (0)")
    product_cart_btn.click
    expect(page).to have_css('#navbar', text: " My Cart (1)")
  end

end