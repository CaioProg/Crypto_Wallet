class WelcomeController < ApplicationController
  def index
    cookies[:curso] = "Curso de Ruby on Rails - Jackson Pires[COOKIE]"
    session[:curso] = "Curso de Ruby on Rails - Jackson Pires[SESSION]"
  end
end
