class TokenController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  skip_after_action :verify_policy_scoped, :only => :index
  def index
    @client = Doorkeeper::Application.first
    puts '--- oauth_authorization'
    puts oauth_authorization_url( {
      client_id: @client.uid,
      redirect_uri: @client.redirect_uri,
      response_type: "code",
      scope: "default_scope",
      })
    puts "--- code"
    puts params[:code]
    puts '--- oauth_token_url'
    puts oauth_token_url( {
      client_id: @client.uid,
      client_secret: @client.secret,
      grant_type:"authorization_code",
      redirect_uri: @client.redirect_uri,
      code: params[:code] || "null"
      })
    puts "---"
  end
end
