module ReposHelper
  # Assign classes based on color
  def activity_color(timestamp)
    diff = Time.zone.now - timestamp
    klass = case diff
            when diff <= 2.months          then 'very-high'
            when (2.months+1)..6.months    then 'high'
            when (6.months+1)..12.months   then 'medium'
            when (12.months+1)..24.months  then 'low'
            else                                'very-low'
            end
    klass
  end
end
