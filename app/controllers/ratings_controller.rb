class RatingsController < ApplicationController
  load_and_authorize_resource

  def create
    @rating = Rating.find_or_initialize_by(book_id: params[:book_id], user_id: params[:user_id])
    @rating.update_attributes(rating_params)
    if params[:rating_number]
      render json: 1
    else
      flash[:success] = 'Your review has been accepted for moderation'
      redirect_to book_path(id: params[:book_id])
    end
  end

  private

    def rating_params
      params.permit(:rating_number, :book_id, :user_id, :review)
    end

end
