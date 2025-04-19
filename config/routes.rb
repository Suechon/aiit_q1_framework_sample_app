Rails.application.routes.draw do
  get 'foo/ber'
  get 'foo/baz'
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'
  # root "hello#index"
  root 'application#hello'
end
