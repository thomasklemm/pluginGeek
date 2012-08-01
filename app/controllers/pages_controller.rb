class PagesController < HighVoltage::PagesController

  layout :layout_for_page

protected

  def layout_for_page
    # case statement can be well applied here
    'application'
  end

end