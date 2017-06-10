module V1
  class BaseController < ApplicationController
    include Roar::Rails::ControllerAdditions
    include PublicActivity::StoreController
    include Pundit
    include Rescuable

    respond_to :json

    before_action :authenticate_user!
    after_action :verify_authorized, except: :index

    def current_user
      @current_user ||= User.from_token(bearer_token) rescue nil if bearer_token
    end

    def authenticate_user!
      current_user || render_error(:invalid_authentication)
    end

    protected

    def bearer_token
      pattern = /^Bearer /
      header = request.headers['Authorization']
      @bearer_token ||= header.gsub(pattern, '') if header && header.match(pattern)
    end
  end
end
