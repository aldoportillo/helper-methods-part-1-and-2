Rails.application.routes.draw do
  get "/" => "movies#index"

  # Routes for the Movie resource:

  # CREATE
  post "/movies" => "movies#create", as: :movies ## => movies_path
  get "/movies/new" => "movies#new", as: :new_movie  ## => new_movie_path
          
  # READ
  get "/movies" => "movies#index" ## => movies_path
  get "/movies/:id" => "movies#show", as: :movie ## => movie_path
  
  # UPDATE
  patch "/movies/:id" => "movies#update" ##Method is implied since it is defined for the get ## => movies_path
  get "/movies/:id/edit" => "movies#edit", as: :edit_movie ## => edit_movie_path
  
  # DELETE
  delete "/movies/:id" => "movies#destroy" ##Method is implied since it is defined for the get ## => movies_path

  #------------------------------
end
