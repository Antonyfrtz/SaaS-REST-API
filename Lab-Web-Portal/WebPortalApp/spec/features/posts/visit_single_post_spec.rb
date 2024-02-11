require "rails_helper"

RSpec.feature "Visit single post", :type => :feature do
  let(:user) { create(:user) }
  let(:category) { Category.create(branch: 'hobby', name: 'Arts') }
  let(:post) { create(:post, user: user, category: category) }

  before do
    post
    visit root_path
  end

  scenario "User goes to a single post from the home page", js: true do
    page.find(".single-post-card").click
    expect(page).to have_selector('body .modal')
    page.find('.interested a').click
    expect(page).to have_selector('#single-post-content p', text: post.content)
  end

end