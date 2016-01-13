Url::Application.routes.draw do
  resources :links do
    member do
      get 'follow'
    end
  end

  root :to => "links#index"
  get '(:id)', :controller => 'links', :action => 'follow'
end