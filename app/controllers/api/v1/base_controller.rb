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

    def page
        @page ||= params[:page] || 1
    end
  
    def per_page
        @per_page ||= params[:per_page] || 10
    end

    def set_pagination_headers(v_name)
        pc = v_name
        
        headers["X-Total-Count"] = pc.total_count

        links = []
        links << page_link(1, "first") if pc.first_page?
        links << page_link(pc.prev_page, "prev") if pc.prev_page
        links << page_link(pc.next_page, "next") if pc.next_page
        links << page_link(pc.total_pages, "last") unless pc.last_page?
        headers["Link"] = links.join(", ") if links.present?
      end
  
      def page_link(page, rel)
        # "<#{posts_url(request.query_parameters.merge(page: page))}>; rel='#{rel}'"
        base_uri = request.url.split("?").first
        "<#{base_uri}?#{request.query_parameters.merge(page: page).to_param}>; rel='#{rel}'"
      end  
end
