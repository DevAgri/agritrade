require 'sidekiq/web'
require 'sidekiq/api'

Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '/', to: 'home#index'

  get '/plano', to: 'plan#index'

  resources :produtos, only: :show, controller: 'products' do
    get '/relatorio', to: 'products#reports'
  end

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
    end
  end
end
