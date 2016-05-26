require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:question_attachment) { create(:attachment, attachable: question) }
  let!(:another_user) { create(:user) }

  describe 'DELETE #destroy' do
    let(:request) do
      delete :destroy,
             question_id: question,
             id: question_attachment,
             format: :js
    end

    before { sign_in(user) }

    context 'User is trying to remove his attachment' do
      it "remove an user's attachment" do
        expect { request }.to change(question.attachments, :count).by(-1)
      end

      it 'render to  destroy view' do
        request
        expect(response).to render_template :destroy
      end
    end

    context 'User is trying to remove his not attachment' do
      it 'does not remove an attachment' do
        sign_in(another_user)
        expect { request }.to_not change(Attachment, :count)
      end
    end
  end
end
