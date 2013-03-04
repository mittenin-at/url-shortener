Url::Application.routes.draw do
  resources :links do 
  	member do
  		get 'follow'
  	end
  end

  root :to => "links#index"    
  match '(:id)', :controller => 'links', :action => 'follow'
end