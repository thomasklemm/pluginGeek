module ReposHelper

  # Review: do this in js on client side
  def activity_color(updated_at)
    diff = Time.now - updated_at
    klass = case diff
            when 0..3.months                      then  'a1'
            when 3.months+1.second..10.months     then  'a2'
            when 10.months+1.second..20.months    then  'a3'
            else                                        'a4'
            end
    klass
  end

end
