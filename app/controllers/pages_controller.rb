class PagesController < HighVoltage::PagesController
  layout :layout_for_page

private

  def layout_for_page
    case params[:id].to_s
    when /404|422|500/
      'errors'
    else
      'application'
    end
  end
end
