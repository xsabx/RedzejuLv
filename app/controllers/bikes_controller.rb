class BikesController < ApplicationController
  before_action :authenticate_user!, only: [:rent, :reserve]   # Ensures that only authenticated users can access the `rent` and `reserve` actions.

  def index
    # Get `start_date` and `end_date` from params or default to today's date.
    @start_date = params[:start_date].presence || session[:start_date] || Date.today.to_s
    @end_date = params[:end_date].presence || session[:end_date] || Date.today.to_s
    @search = params[:search]
  
    start_date = Date.parse(   @start_date)
    end_date = Date.parse(@end_date)
  
    @bikes = Bike.all
  
    #Store the selected dates in the session so they can be used later in the `rent` action.
    session[:start_date] = @start_date
    session[:end_date] = @end_date
  
    # Filter bikes based on date range.
    unless params[:start_date].blank? && params[:end_date].blank?
      if end_date < Date.today
        flash.now[:alert] = "End date cannot be in the past."
      elsif end_date < start_date
        flash.now[:alert] = "End date cannot be before start date."
      else
        @bikes = @bikes.where.not(id: Bike.joins(:rentals)
                                        .where("rentals.start_date <= ? AND rentals.end_date >= ?", end_date, start_date))
      end
    end
  
    # Filter bikes by name, bike type, or frame size.
    if @search.present?
      @bikes = @bikes.where("name LIKE ? OR bike_type LIKE ? OR frame_size LIKE ?", 
                            "%#{@search}%", "%#{@search}%", "%#{@search}%")
    end
  end

  # Show details of a specific bike before reserving it.
  def rent
    @bike = Bike.find(  params[:id])
    # Set the start and end dates for the form based on the previously selected dates from the session.
    @start_date = session[:start_date]
    @end_date = session[:end_date]
  end

  # Handle the reservation of a bike.
  def reserve
    @bike = Bike.find(params[:id])
    start_date = params[:start_date]
    end_date = params[:end_date]

    # Create a new rental record for the current user (and validation for data).
    if start_date.blank? || end_date.blank?
             redirect_to rent_bike_path(@bike), alert: "Please select both start and end dates."
    elsif start_date.to_date > end_date.to_date
      redirect_to rent_bike_path(@bike), alert: "End date cannot be before start date."
    else
      @rental = current_user.rentals.new(
        bike: @bike, 
        start_date: start_date, 
        end_date: end_date
      )
      
      # If the rental is successfully saved, redirect to the rentals list with a success message.
      if @rental.save
        redirect_to rentals_path, notice: "You have successfully reserved the bike."
      else
         # If there are validation errors, redirect back to the rent page with the errors.
        redirect_to rent_bike_path(@bike), alert: @rental.errors.full_messages.to_sentence
      end
    end
  end
end
