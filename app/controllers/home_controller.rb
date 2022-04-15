class HomeController < ApplicationController
  def index
    render json: {
      home:"welcome"
    }
  end
end
