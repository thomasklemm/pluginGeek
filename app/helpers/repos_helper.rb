module ReposHelper

  def activity_color(updated_at)
    diff = Time.now - updated_at
    klass = case diff
            when 0..2.months                    then 'first'
            when 2.months+1.second..6.months    then 'second'
            when 6.months+1.second..12.months   then 'third'
            when 12.months+1.second..18.months  then 'fourth'
            when 18.months+1.second..24.months  then 'fifth'
            else 'sixth'
            end
    klass
  end

end
