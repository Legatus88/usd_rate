require 'rails_helper'

RSpec.feature "Rate Features", type: :feature do
  context 'create new timer' do
    before(:each) do
      visit '/admin'
    end

    scenario "should raise error" do
      within('form') do
        find('#timer_date_1i').all(:css, 'option').find { |o| o.value == '2024' }.select_option
        find('#timer_deadline_5i').all(:css, 'option').find { |o| o.value == "#{(Time.current - 5.minute).strftime("%M")}" }.select_option
      end
      click_button "Create Timer"

      expect(page).to have_content 'Date is invalid'
      expect(page).to have_content 'Deadline is invalid'
    end

    scenario "should redirect to root" do
      within('form') do
        find('#timer_date_1i').all(:css, 'option').find { |o| o.value == "2015" }.select_option
        find('#timer_date_2i').all(:css, 'option').find { |o| o.value == "1" }.select_option
        find('#timer_date_3i').all(:css, 'option').find { |o| o.value == "1" }.select_option
        find('#timer_deadline_5i').all(:css, 'option').find { |o| o.value == "#{(Time.current + 5.minute).strftime("%M")}" }.select_option
      end
      click_button "Create Timer"

      expect(page).to have_current_path(root_path)
      expect(page).to have_content '56,2376'
    end

    scenario "should keep last timer in form" do
      within('form') do
        find('#timer_date_1i').all(:css, 'option').find { |o| o.value == "2015" }.select_option
        find('#timer_date_2i').all(:css, 'option').find { |o| o.value == "1" }.select_option

        find('#timer_deadline_5i').all(:css, 'option').find { |o| o.value == "#{(Time.current + 5.minute).strftime("%M")}" }.select_option
      end
      click_button "Create Timer"

      expect(page).to have_current_path(root_path)

      visit '/admin'

      expect(page).to have_content '2015'
      expect(page).to have_content 'January'
    end

  end
end
