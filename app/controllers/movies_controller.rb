class MoviesController < ApplicationController
  def new
    @movie = Movie.new
    # Render is assumed since view is in views/movies/new and controller is Movies#new
  end

  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :created_at => :desc })

    respond_to do |format|
      format.json do
        render json: @list_of_movies
      end

      format.html do
        render "movies/index"
        #Can maybe remove this too I think
      end
    end
  end

  def show
    id = params.fetch(:id)

    matching_movies = Movie.where({ :id => id })

    @movie = matching_movies.first

    ##Render is assumed
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch("query_title")
    @movie.description = params.fetch("query_description")

    if @movie.valid?
      @movie.save
      redirect_to(movies_url, { :notice => "Movie created successfully." })
    else
      render "movies/new"
    end
  end

  def edit
    id = params.fetch(:id)

    matching_movies = Movie.where({ :id => id })

    @movie = matching_movies.first

    #View is assumed
  end

  def update
    id = params.fetch(:id)
    movie = Movie.where({ :id => id }).first

    movie.title = params.fetch("query_title")
    movie.description = params.fetch("query_description")

    if movie.save
      redirect_to(movie_path(movie), { :notice => "Movie updated successfully."} )
    else
      redirect_to(movie_path(movie), { :alert => "Movie failed to update successfully. #{movie.errors.full_messages.split.join(". ")}." })
    end
  end

  def destroy
    id = params.fetch(:id)
    movie = Movie.where({ :id => id }).first

    movie.destroy

    redirect_to(movies_path, { :notice => "Movie deleted successfully."} )
  end
end
