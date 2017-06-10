require 'sidekiq/web'
require 'sidekiq/api'

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  scope '/api' do
    api_version(
      module: 'V1',
      path: {
        value: 'v1'
      },
      defaults: {
        format: :json
      }
    ) do
      resources :sessions, only: :create, path: :auth do
        collection do
          scope module: 'sessions' do
            post ':provider', to: 'providers#create', as: 'providers'
          end
        end
      end

      get 'me', to: 'sessions#show'

      resources :requests, only: [:index, :create] do
        collection do
          get 'report', to: 'requests_report#index'
        end
      end
    end
  end
end
