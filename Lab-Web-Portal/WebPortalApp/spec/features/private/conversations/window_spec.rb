require "rails_helper"

RSpec.feature "window", :type => :feature do
  let(:user) { create(:user) }
  let(:conversation) { create(:private_conversation, sender_id: user.id) }
  let(:open_window) do
    sign_in user
    visit root_path
    page.find('#conversations-menu .dropdown-toggle').click
    page.find('#conversations-menu li a').click
    expect(page).to have_selector('.conversation-window')
  end
  before(:each) do 
    conversation
    create(:private_message, conversation_id: conversation.id, user_id: user.id)
  end

  scenario 'user opens a conversation', js: true do
    open_window
  end

  scenario 'user closes open conversations', js: true do 
    open_window
    # Keep closing conversations while .close-conversation element is detected
    while page.has_selector?('.close-conversation')
      page.find('.close-conversation').click
    end
    # Assert that the .close-conversation element is no longer present
    expect(page).not_to have_selector('.close-conversation')
  end

  scenario 'user sends a message', js: true do 
    open_window
    expect(page).to have_selector('.conversation-window .messages-list li', count: 1)
    find('.conversation-window').fill_in 'body', with: 'hey, mate'
    find('.form-control').send_keys(:enter)
    expect(page).to have_selector('.conversation-window .messages-list li', count: 2)
  end

  scenario 'user collapses and expands a conversation window', js: true do
    open_window
    find('.conversation-window .conversation-heading').click
    expect(page).to have_css('.panel-body', visible: false)
  end

  scenario "Mark unseen messages as seen when opening a conversation window" do
    # open_window
    # expect(page).to have_selector('unseen')
    # find('.panel-body').click
  end

  scenario "Mark unseen messages as seen when clicking directly on a conversation window" do
    # let(:user2) { create(:user) }
    # create(:private_message, conversation_id: conversation.id, user_id: user2.id)
    # find('.conversation-window .conversation-heading').click
    # find('.panel-body').click
  end

end