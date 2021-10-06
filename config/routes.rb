# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  get '*path', to: 'cms/pages#show',
               constraints: ->(request) { Cms::Page.active.find_by(path: request.path_info) }
  get '/cms/preview/:path', to: 'cms/pages#preview', as: :preview_page

  namespace :admin do
    resources :custom_pages do
      resources :components do
        resources :components do
          member do
            put :move_to
          end
        end
        member do
          put :move_to
        end
      end
      member do
        get :preview
      end
    end
  end
end
