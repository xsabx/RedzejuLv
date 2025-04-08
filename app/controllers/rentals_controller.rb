class RentalsController < ApplicationController
  before_action :authenticate_user! #Ensures that only authenticated users can access any actions in this controller.

  #display a list of all rentals associated with the currently logged-in user.
  def index
    @rentals = current_user.rentals
  end

  # Action to allow a user to cancel one of their rentals.
  def destroy
    @rental = current_user.rentals.find(params[:id])
    @rental.destroy
    redirect_to rentals_path, notice: "Your reservation has been canceled."
  end
end
