class PerformancesController < ApplicationController
  before_action :authenticate_user!, only: [:mark_seen, :save_seen, :save_review]

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
      search_query = "%#{@search.downcase}%"
      @performances = @performances.where(
        "LOWER(title) LIKE :q OR LOWER(theater) LIKE :q OR LOWER(description) LIKE :q",
        q: search_query
      )
    end
  end

  # Parāda konkrētas izrādes informāciju un formu atzīmēšanai kā redzēta
  def mark_seen
    @performance = Performance.find(params[:id])
    @seen_at = Date.today.to_s
    @existing_review = current_user.reviews.find_by(performance: @performance)
    @other_reviews = @performance.reviews.where.not(user: current_user).includes(:user).order(created_at: :desc)
  end

  # Saglabā, ka lietotājs ir redzējis izrādi
  def save_seen
    @performance = Performance.find(params[:id])
    seen_at = params[:seen_at]

    if seen_at.blank?
      redirect_to mark_seen_performance_path(@performance), alert: "Lūdzu, ievadi redzēšanas datumu."
      return
    end

    seen = current_user.seen_performances.new(
      performance: @performance,
      seen_at: seen_at
    )

    if seen.save
      redirect_to mark_seen_performance_path(@performance), notice: "Izrāde atzīmēta kā redzēta."
    else
      redirect_to mark_seen_performance_path(@performance), alert: seen.errors.full_messages.to_sentence
    end
  end

  # Saglabā lietotāja atsauksmi
  def save_review
    @performance = Performance.find(params[:id])
    
    review = current_user.reviews.new(
      performance: @performance,
      content: params[:review],
      rating: params[:rating],
      seen_at: params[:seen_at]
    )

    if review.save
      redirect_to mark_seen_performance_path(@performance), notice: "Atsauksme saglabāta."
    else
      redirect_to mark_seen_performance_path(@performance), alert: review.errors.full_messages.to_sentence
    end
  end
end
