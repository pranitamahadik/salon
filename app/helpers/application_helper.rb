module ApplicationHelper
  def link_to_add_fields(name, f, association, options = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    Rails.logger.info "new_object----#{id}"
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    css_class = "add_fields #{options[:css_class]}"
    link_to(name, '#', class: css_class, data: {id: id, fields: fields.gsub("\n", "")})
  end

  def flash_message
    content_tag(:div, class: "alert alert-primary", role: "alert", style: "line-height: 34px; padding-left: 10px; margin: 0;") do
      flash[:notice]
    end
  end

  def fetch_salon_list
    SalonInfo.where("chair_count > ?", 0)&.pluck(:company_name, :id) 
  end
end

