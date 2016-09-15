class ConfirmationsController < ApplicationController
  def new
  	@confirmation = Confirmation.new
  end

  def create
  	@confirmation = Confirmation.new(confirrmation_params)
  	@confirmation.save
  	# def to create token
  	# update token into the database
  	redirect_to root_path
  end

  def update
  end

  private

  def confirrmation_params
  	params.require(:confirmation).permit(:phone_number)
  end
end
