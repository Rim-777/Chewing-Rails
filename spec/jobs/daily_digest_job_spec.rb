require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:users) { create_list(:user, 2) }

  it 'sends daily digests' do
    users.each { |user| expect(UserNotificationMailer).to receive(:digest).with(user).and_call_original }
    DailyDigestJob.perform_now
  end
end
