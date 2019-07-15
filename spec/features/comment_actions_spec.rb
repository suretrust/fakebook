# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'CommentActions', type: :feature do
  let(:comment) { create :comment }

  before do
    feature_sign_in(comment.user.email, comment.user.password)
    fill_in "What's happening?", with: comment.post.post_content
    click_on 'Publish'
    fill_in 'Comment on this post.', with: 'First test comment'
    click_on 'Comment'
  end

  scenario 'adds a comment to the post' do
    expect(page).to have_content('Comment added')
    expect(page).to have_content('First test comment')
  end

  scenario "edits the post's comment" do
    within '.comment-edit-button' do
      click_on 'Edit'
    end
    fill_in 'Comment on this post.', with: 'Updated comment'
    click_on 'Comment'
    expect(page).to have_content('Comment updated')
  end

  scenario "deletes the post's comment" do
    within '.comment-delete-button' do
      click_on 'Delete'
    end
    expect(page).to have_content('Comment deleted')
  end
end
