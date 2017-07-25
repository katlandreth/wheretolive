Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'countries#index'

   resources :countries
   get 'maps' => 'maps#show', as: :maps
   post 'overall_rank' => 'maps#overall_rank', as: :overall_rank

  #  get 'scrape_countries' => 'countries#scrape_satisfaction_data', as: :scrape_satisfaction_data
  #  get 'scrape_gps_data' => 'countries#scrape_gps_data', as: :scrape_gps_data
  #  get 'scrape_code_data' => 'countries#scrape_code_data', as: :scrape_code_data
  #  get 'scrape_cost_of_living_data' => 'countries#scrape_cost_of_living_data', as: :scrape_cost_of_living_data
  #  get 'scrape_education_data' => 'countries#scrape_education_data', as: :scrape_education_data
  #  get 'scrape_freedom_of_press_data' => 'countries#scrape_freedom_of_press_data', as: :scrape_freedom_of_press_data




  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
