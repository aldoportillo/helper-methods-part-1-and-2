class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new
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
    the_id = params.fetch(:id)

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.first

    ##Render is assumed
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("query_title")
    @the_movie.description = params.fetch("query_description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to(movies_url, { :notice => "Movie created successfully." })
    else
      render "movies/new"
    end
  end

  def edit
    the_id = params.fetch(:id)

    matching_movies = Movie.where({ :id => the_id })

    @the_movie = matching_movies.first

    #View is assumed
  end

  def update
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.title = params.fetch("query_title")
    the_movie.description = params.fetch("query_description")

    if the_movie.save
      redirect_to(movie_path(the_movie), { :notice => "Movie updated successfully."} )
    else
      redirect_to(movie_path(the_movie), { :alert => "Movie failed to update successfully. #{the_movie.errors.full_messages.split.join(". ")}." })
    end
  end

  def destroy
    the_id = params.fetch(:id)
    the_movie = Movie.where({ :id => the_id }).first

    the_movie.destroy

    redirect_to(movies_path, { :notice => "Movie deleted successfully."} )
  end
end
