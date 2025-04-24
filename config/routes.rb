Rails.application.routes.draw do
  # Root route
  root "emails#new"

  # Email sending routes
  resources :emails, only: [:new, :create]

  # CKEditor upload route
  mount Ckeditor::Engine => '/ckeditor'

  # Authentication routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Health check (for uptime monitoring)
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA manifest and service worker (if used)
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest

  # Catch-all fallback route to handle unknown paths (optional)
  match "*path", to: redirect("/"), via: :all
end
