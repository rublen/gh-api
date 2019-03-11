class OauthService
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    token = auth.credentials.token
    uid = auth.uid #|| Github::Api.new(token).uid
    authorization = Authorization.find_by(uid: uid)

    if authorization
      user = authorization.user
    else
      email = auth.info.email #|| Github::Api.new(token).email
      user = User.find_by(email: email) || User.create!(email: email, password: Devise.friendly_token[0, 20]) if email
      authorization = user.authorizations.find_by(provider: auth.provider) ||
                      user.authorizations.create(uid: uid, provider: auth.provider, email: email)
    end

    authorization.update(
      token: token
      # expires_at: auth[:credentials][:expires_at],
      # refresh_token: auth[:credentials][:refresh_token]
    )

    user
  end
end
