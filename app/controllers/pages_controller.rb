class PagesController < HighVoltage::PagesController

  layout :layout_for_page

protected
  
  def layout_for_page
    # Requested Page is specified in params[:id]
    case params[:id]
    when 'readmejs'
      false
    else
      'application'
    end
  end

end