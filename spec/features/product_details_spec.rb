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

  scenario "They see all products and click on one to see its details" do
    # ACT
    visit root_path

    # DEBUG / VERIFY
    #save_screenshot

    expect(page).to have_css 'article.product', count: 10

    #product = page.all('article').first
    product_details_btn = page.first( 'a.btn.btn-default.pull-right' )
    product_details_btn.click

    # only when logged in: expect(page).to have_css '.new_review'
    # block
    expect(page).to have_css('dt')
    all_dts = page.all('dt')

    found_description = false
    all_dts.each do | my_dt |
      if my_dt.text == 'Description'
        found_description = true
      end
    end

    expect(found_description).to be true
    # DEBUG / VERIFY
    save_screenshot

  end
end