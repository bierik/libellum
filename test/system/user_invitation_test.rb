require 'application_system_test_case'

class UserInvitationTest < ApplicationSystemTestCase
  include ActionMailer::TestHelper

  test 'Administrators can invite users' do
    sign_in users(:admin)

    visit root_path
    click_on 'Benutzer einladen'

    fill_in 'Vorname', with: 'Harry'
    fill_in 'Nachname', with: 'Potter'
    fill_in 'E-Mail', with: 'harry.potter@example.org'
    click_on 'Einladung senden'

    p ActionMailer::Base.deliveries.first
    sleep
    assert_emails 1

    # Parse invitation token out of the sent email.
    # This is needed as the invitation token is stored encrypted in the database.
    plain_text_message = ActionMailer::Base.deliveries.first.parts.find do |part|
      part.content_type.include?('text/plain')
    end.decoded
    invitation_token = plain_text_message.match(/invitation_token=(?<token>.+)\n/)[:token]

    invited_user = User.find_by(email: 'harry.potter@example.org')
    assert_equal [organizations(:fahrlehrer_peter)], invited_user.organizations

    sign_out(:user)

    visit accept_user_invitation_path(invitation_token: invitation_token)
    find('h2', text: 'Setze ein Passwort')

    fill_in 'Passwort', with: 'hogwarts'
    fill_in 'Passwortbestätigung', with: 'hogwarts'
    click_on 'Passwort setzen'

    assert_equal "Dein Passwort wurde gesetzt. Du bist nun angemeldet.\n×", find('div.alert').text

    assert invited_user.reload.invitation_accepted_at
  end
end
