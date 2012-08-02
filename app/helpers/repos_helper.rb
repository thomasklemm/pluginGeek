module ReposHelper

  # Review: do this in js on client side
  def activity_color(updated_at)
    diff = Time.now - updated_at
    klass = case diff
            when 0..4.months                      then  'one'
            when 4.months+1.second..12.months     then  'two'
            when 12.months+1.second..24.months    then  'three'
            else                                        'four'
            end
    klass
  end

end
