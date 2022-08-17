class SalonInfosController < ApplicationController
  def new
    @salon_info = SalonInfo.new()
    @salon_services = @salon_info.salon_services.build
  end

  def index
    @salon_info = SalonInfo.new
    @salon_infos = SalonInfo.all
  end

  def create
    @salon_info = SalonInfo.create(salon_info_params)
    if @salon_info.save
      flash[:notice] = "Data Save Successfully"
      redirect_to :action => "index"
    else
      render :new
    end
  end

  def get_salon_services
    salon_info = SalonInfo.find_by_id(params[:salon_info])
    salon_services_list = salon_info&.salon_services.map{|service| [service.id.to_s, service.service_type]}
    
    render json: { salon_services_list: salon_services_list, time_slot_list: fetch_available_slots(salon_info)}
  end

  private

  def salon_info_params
    params.require(:salon_info).permit(:company_name, :gstin, :pan, :address, :chair_count, :day, :open, :closes, salon_services_attributes: {})
  end

  def fetch_available_slots(salon_info)
    time_slot_list = []
    duration = 30

    while (salon_info.open.strftime("%H:%M") <= salon_info.closes.strftime("%H:%M")) do
      time_slot_list << salon_info.open.strftime("%H:%M")
      salon_info.open += duration.minutes
    end

    result_array = []
    time_slot_list.each do |time|
      result = {}
      result[:count] = salon_info.chair_count
      result[:slot] = time
      result_array << result
    end

    appointment_result = []
    salon_info.appointments.where("DATE(created_at) = ?", Date.today).each do |appo|
      appointment_info = {}
      appointment_info[:start_time] = appo.start_time.strftime("%H:%M")
      appointment_info[:duration] = appo.salon_service.duration.strftime("%H:%M")
      appointment_result << appointment_info
    end
    
    final_result = []
    if appointment_result.present?
      appointment_result.each do |appo_result|
        result_array.each do |result|
          if appo_result[:start_time] == result[:slot]
            result[:count] = result[:count] - 1
            if !result[:count].zero?
              final_result << result[:slot]
            end
          else
            final_result << result[:slot]
          end
        end
      end
    else
      result_array.each do |result|
        final_result << result[:slot]
      end
      return final_result
    end
    return final_result.select{ |x| final_result.count(x) > 1}.uniq
  end
end

