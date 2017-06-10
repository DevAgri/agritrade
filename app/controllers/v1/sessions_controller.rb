module V1
  class SessionsController < BaseController
    skip_after_action :verify_authorized

    with_options only: :create do
      skip_before_action :authenticate_user!

      before_action :normalize_params
      before_action :set_user
    end

    def create
      @session = Session.new(@user).authenticate params[:password]
      unless @session
        render_error(:invalid_credentials)
      else
        respond_with(@session, location: nil)
      end
    end

    def show
      respond_with(current_user)
    end

    private

    def normalize_params
      params[:email_or_username] ||= params[:email] || params[:username]
    end

    def set_user
      render_error :parameter_missing and return if params[:email_or_username].blank?
      @user ||= User.email_or_username(params[:email_or_username]).take!
    rescue ActiveRecord::RecordNotFound
      render_error :invalid_credentials
    end
  end
end
