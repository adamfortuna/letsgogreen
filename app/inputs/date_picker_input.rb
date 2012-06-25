class DatePickerInput < SimpleForm::Inputs::Base
  def input
    "<div class=\"input-append date\" data-date=\"12-02-2012\" data-date-format=\"dd-mm-yyyy\">#{@builder.text_field(attribute_name, input_html_options)}<span class=\"add-on\"><i class=\"icon-th\"></i></span></div>".html_safe
  end
end