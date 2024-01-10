# frozen_string_literal: true

Spree::Core::Engine.routes.draw do
  scope module: 'solidus_cms' do
    get '*path', to: 'pages#show', constraints: ->(request) { SolidusCms::Page.active.find_by(path: request.path_info) }
    get '/preview/:path', to: 'pages#preview', as: :preview_page

    namespace 'admin' do
      resources :custom_pages do
        resources :components do
          resources :components do
            member { put :move_to }
          end
          member { put :move_to }
        end
        member { get :preview }
      end
    end
  end
end
