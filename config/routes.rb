Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 	resources :producers do
	  collection do
	    get 'send_message'
	  end
	end

	resources :consumers do
	  collection do
	  	get 'load_message'
	    get 'next_message'
	  end
	end

end