class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user_for_oauth, only: [:github]

  def github
    login_with('github') if @user.persisted?
  end

  private

  def set_user_for_oauth
    auth = request.env['omniauth.auth']
    @user = OauthService.new(auth).call
  end

  def login_with(provider)
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
  end
end
