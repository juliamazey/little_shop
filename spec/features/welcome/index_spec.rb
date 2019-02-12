require 'rails_helper'

RSpec.describe 'when i visit the root path' do
  context 'as registered user' do
    it 'has a link for logging in' do
      visit root_path

      click_on "Log in"

      expect(current_path).to eq(login_path)
    end
  end
end
