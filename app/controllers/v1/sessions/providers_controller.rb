module V1
  module Sessions
    class ProvidersController < SessionsController
      skip_before_action :set_user

      def create
        if params[:access_token].blank?
          render_error(:parameter_missing)
        else
          user = UserProvider.find_or_create_by_provider!(params[:provider], params[:access_token])
          respond_with(Session.new(user), location: nil, represent_with: V1::SessionRepresenter)
        end
      end
    end
  end
end
