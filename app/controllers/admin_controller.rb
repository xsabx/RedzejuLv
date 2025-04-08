# app/controllers/admin_controller.rb
class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @users = User.includes(:rentals).all
  end

  # Action to delete a user and all their reservations
  def destroy_user
    user = User.find(params[:id])
    if user != current_user # Prevent an admin from deleting themselves
      user.rentals.destroy_all # Delete all reservations associated with the user
      user.destroy
      flash[:notice] = "User and associated reservations deleted successfully."
    else
      flash[:alert] = "You cannot delete your own account."
    end
    redirect_to admin_dashboard_path
  end

  # Action to delete an individual reservation
  def destroy_reservation
    rental = Rental.find(params[:id])
    rental.destroy
    flash[:notice] = "Reservation deleted successfully."
    redirect_to admin_dashboard_path
  end

  private

  def check_admin
    redirect_to root_path, alert: "Not authorized" unless current_user&.admin?
  end
end

