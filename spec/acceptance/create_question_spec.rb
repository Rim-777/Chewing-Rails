require_relative 'acceptance_helper'

feature 'Create Question', %q{
In order to get answer as an authenticated user
I want to be able to ask questions } do
  given(:user) { create(:user) }
  scenario 'the uthenticated user is trying to ask a question' do
    sign_in(user)
    visit questions_path
    click_on 'Ask question'
    fill_in 'question_title', with: 'Test question'
    fill_in 'question_body', with: 'Test question body'
    click_on 'Create'
    expect(page).to have_content 'Test question'
    expect(page).to have_content 'Test question body'
  end

  scenario 'some unauthenticated user is trying to ask a question' do
    visit questions_path
    expect(page).to_not have_link 'Ask question'
  end
end
