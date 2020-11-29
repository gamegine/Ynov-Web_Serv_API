class Api::V1::BaseController < ActionController::API
    #before_action :authenticate_user!
    # Doorkeeper
    before_action :doorkeeper_authorize!

    include Pundit

    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

    private 

    def skip_pundit?
        devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end

    # force pundit policie user from token
    def pundit_user
        User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
end
