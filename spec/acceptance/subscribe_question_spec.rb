require_relative 'acceptance_helper'

feature 'Subscribe question', %q{
In order to get updates about question
 as an authenticated user I want to be able to subscribe questions } do
  given(:some_authenticated_user) { create(:user) }
  given(:author_of_question) {create(:user)}
  given(:question) { create(:question, user: author_of_question) }

  scenario 'some authenticated user is trying to subscribe the question', js: true do
    sign_in(some_authenticated_user)
    visit question_path(question)
    expect(page).to have_button "question_#{question.id}_subscribe_link"

    click_on "question_#{question.id}_subscribe_link"
    sleep(1)

    expect(page).to_not have_link "question_#{question.id}_subscribe_link"
    expect(page).to have_button "question_#{question.id}_unsubscribe_link"
  end

  scenario 'some authenticated user is trying unsubscribe the question', js: true do
    sign_in(some_authenticated_user)
    visit question_path(question)
    
    click_on "question_#{question.id}_subscribe_link"
    sleep(1)

    expect(page).to have_button "question_#{question.id}_unsubscribe_link"
    click_on "question_#{question.id}_unsubscribe_link"
    sleep(1)
    expect(page).to_not have_link "question_#{question.id}_unsubscribe_link"
    expect(page).to have_button "question_#{question.id}_subscribe_link"
  end
end
