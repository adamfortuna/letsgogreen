class DatePickerInput < SimpleForm::Inputs::Base
  def input
    date = @builder.object.send(attribute_name)
    if date.nil?
      date = Date.today
    end

    input_html_options.merge!(value: date.strftime("%m/%d/%Y"))
    "<div class=\"input-append date\" data-date-format=\"mm-dd-yyyy\">#{@builder.text_field(attribute_name, input_html_options)}<span class=\"add-on\"><i class=\"icon-th\"></i></span></div>".html_safe
  end
end