require 'rails_helper'

RSpec.describe "Users::Edit", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    get edit_user_registration_path
  end

  it "statusが200であること" do
    expect(response.status).to eq(200)
  end

  it "ユーザー名の表示" do
    expect(response.body).to include user.email
  end
end
