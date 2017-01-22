class ConfirmationsController < ApplicationController
  def new
  	@confirmation = Confirmation.new
  end

  def create
    @confirmation = Confirmation.find_by(otp: params[:confirmation][:otp])
    if @confirmation
      @confirmation.update_attributes(confirmation_params.merge(confirmed: true))
      @confirmation.order.update_attributes(confirmation_id: @confirmation.id, state: State.confirmed)
      redirect_to order_summary_path(@confirmation.order.id)
    elsif !@confirmation
      @confirmation = Confirmation.new(confirmation_params.merge(confirmed: false, otp: Confirmation.one_time_password))
      if @confirmation.save
        flash[:success] = "Your order reference number is: #{@confirmation.otp}"
        redirect_to root_path 
      else
        flash.now[:error] = "Phone number can't be blank"
        render action: :new
      end
    else
      flash.now[:error] = "contact your administrator"
    end       
  end

  def update
    @confirmation = Confirmation.find(params[:id])
    if @confirmation.update_attributes(confirmation_params)
      redirect_to @confirmation
    end
  end

  private

  def confirmation_params
  	params.require(:confirmation).permit(:phone_number, :customer_id, :order_id)
  end
end
