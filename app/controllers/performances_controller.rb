class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: [:mark_seen, :save_seen]

  def index
    # Iegūst filtrēšanas datumu (ja nepieciešams) vai visu sarakstu
    @search = params[:search]
    @date = params[:date].presence || session[:date]

    @performances = Performance.all

    # Saglabā filtrēšanas datumu sesijā
    session[:date] = @date if @date.present?

    # Filtrē pēc izrādes datuma
    if @date.present?
      begin
        date = Date.parse(@date)
        @performances = @performances.where(performed_at: date.all_day)
      rescue ArgumentError
        flash.now[:alert] = "Nederīgs datuma formāts."
      end
    end

    # Meklēšana pēc nosaukuma, teātra vai apraksta
    if @search.present?
      @performances = @performances.where(
        "title ILIKE :q OR theater ILIKE :q OR description ILIKE :q",
        q: "%#{@search}%"
      )
    end
  end

  # Parāda konkrētas izrādes informāciju un formu atzīmēšanai kā redzēta
  def mark_seen
    @performance = Performance.find(params[:id])
    @seen_at = Date.today.to_s
  end

  # Saglabā, ka lietotājs ir redzējis izrādi
  def save_seen
    @performance = Performance.find(params[:id])
    seen_at = params[:seen_at]

    if seen_at.blank?
      redirect_to mark_seen_performance_path(@performance), alert: "Lūdzu, ievadi redzēšanas datumu."
    else
      seen = current_user.seen_performances.new(
        performance: @performance,
        seen_at: seen_at
      )

      if seen.save
        redirect_to performances_path, notice: "Izrāde atzīmēta kā redzēta."
      else
        redirect_to mark_seen_performance_path(@performance), alert: seen.errors.full_messages.to_sentence
      end
    end
  end
end
