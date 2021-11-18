class MoviesController < ApplicationController
  def index
    if params[:query].present?
      query = "%#{params[:query]}%"

      where = "title @@ :query \
        OR synopsis @@ :query \
        OR directors.first_name @@ :query \
        OR directors.last_name @@ :query"
      @movies = Movie.joins(:director).where(where, query: query)
    else
      @movies = Movie.all
    end
  end
end
