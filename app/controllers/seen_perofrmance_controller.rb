class SeenPerformancesController < ApplicationController
  before_action :authenticate_user! # Tikai autentificēti lietotāji drīkst skatīt/rediģēt savas redzētās izrādes

  # Parāda visas izrādes, ko pašreizējais lietotājs ir atzīmējis kā redzētas
  def index
    @seen_performances = current_user.seen_performances.includes(:performance)
  end

  # Ļauj dzēst redzēto izrādi (piemēram, ja atzīmēta kļūdaini)
  def destroy
    @seen_performance = current_user.seen_performances.find(params[:id])
    @seen_performance.destroy
    redirect_to seen_performances_path, notice: "Izrāde ir noņemta no redzēto saraksta."
  end
end
