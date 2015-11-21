require 'rails_helper'

feature "Browse question and it's answers", %q{To find the answer or answer the question,
I want to be able to  browse the question and it's answers
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, :has_answers) }


  scenario 'Authenticate User is trying to see a question and answers' do
    sign_in(user)
     every_one_can_see_question_with_answers
  end

  scenario 'Un-Authenticate User is trying to see a question and answers' do
    every_one_can_see_question_with_answers

  end

end




