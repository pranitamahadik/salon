class AppointmentsController < ApplicationController

  def new
    @appointment = Appointment.new()
  end

  def index
    @appointments = Appointment.all
  end

  def create
    @appointment = Appointment.new(appointment_params)
    if @appointment.save
      flash[:notice] = "Your Appointment Created Successfully"
      redirect_to :action => "index"
    else
      render :new
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:salon_info_id, :salon_service_id, :user_name, :mobile, :gender, :start_time)
  end
end