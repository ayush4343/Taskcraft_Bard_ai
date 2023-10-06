Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # config/routes.rb
  post '/process_text', to: 'bard_ai#process_text'
end
