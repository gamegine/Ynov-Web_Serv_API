class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    include Pundit

    after_action :verify_authorized, except: :index, unless: :skip_pundit?
    after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

    private 

    def skip_pundit?
        devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
    end

    def after_sign_in_path_for(resource) # after devise login go back to oauth-authorize id src
        stored_location_for("doorkeeper-oauth-authorize") || root_path
    end
end
