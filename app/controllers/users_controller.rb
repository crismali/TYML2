class UsersController < ApplicationController

  def dashboard
    current_user
  end

  def sent
    current_user
  end


end
