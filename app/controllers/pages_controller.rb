class PagesController < HighVoltage::PagesController

  layout :layout_for_page

protected
  
  def layout_for_page
    'application'
  end

end