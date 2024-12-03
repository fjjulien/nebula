class ApplicationController < ActionController::Base
  before_action :set_locale
  append_view_path "doc"

  def home; end

  def test; end

  def user_signed_in?
    session[:handle].present?
  end

  def user_signed_in!
    unless user_signed_in?
      flash.alert = "You must be logged in to access this section"
      redirect_back(fallback_location: root_path)
      return # Stop further execution
    end
  end

  def authenticate_user!
    user_signed_in!
    return true if  Rails.env.test?
  
    # TODO: Replace with user table
    if ["dlh28",
      "MorganPann",
      "GaryMan1968",
      "fjjulien",
      "saumier",
      "Liverace",
      "sahalali",
      "tammy-culture",
      "MichifDorian",
      "troughc"].include?(session[:handle])
      return true
    else
      flash.alert = "#{session[:name]} does not have sufficient permissions to access this section."
      redirect_back(fallback_location: root_path)
    end
   
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # TODO: Figure out if this is needed
  # def default_url_options
  #   { locale: I18n.locale }
  # end
end
