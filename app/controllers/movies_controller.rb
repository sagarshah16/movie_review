class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
 # before_action :authenticate_user!, expect: [:index, :show]
  before_action :set_rating_array
 def asort
  @movies = Movie.order(:Title)
 end

 def dsort
  @movies = Movie.order(Title: :DESC)
  end

 def search
  if params[:search].present?
    @movies = Movie.search(params[:search])
  else
    @movies = Movie.all
  end
 end   
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
   
  end

  def rsort
    @avg_review = @avg_review
    @movies = Movie.order(@sort_rating)
  end
  # GET /movies/1
  # GET /movies/1.json
  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")
  
   if @reviews.blank?
    @avg_review = 0
   else
    @avg_review = @reviews.average(:rating).round(2)
   end
  end

  # GET /movies/new
  def new
    @movie = current_user.movies.build
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating_array
      @movies = Movie.all
      @avg_review = []
      @has_rating = {}
    @movies.each do |movie|
      @reviews = Review.where(movie_id: movie.id).order("created_at DESC")
     
   if @reviews.blank?
    @avg_review.push(0)
   else
   @avg_review.push(@reviews.average(:rating).round(2))
   @has_rating.store(movie.id, @reviews.average(:rating).round(2))
   end
    
 end
end
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:Title, :Description, :Duration, :Actor, :Rating, :image)
    end
end
