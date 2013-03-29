class RepoDecorator < Draper::Decorator
  delegate_all

  decorates_association :categories
  decorates_association :parents_and_children

  def owner
    model[:owner].present? ? model[:owner] : full_name.split('/')[0]
  end

  def name
    model[:name].present? ? model[:name] : full_name.split('/')[1]
  end

  def description
    model[:description].present? ? model[:description] : github_description
  end

  def github_description
    model[:github_description].present? ? model[:github_description] : ""
  end

  # Returns either homepage url as an absolute path if only a relative one is given
  # or the github_url
  def homepage_url
    url = model[:homepage_url]

    if url.present?
      url.start_with?('http') or "http://#{ url }"
    else
      github_url
    end
  end

  def github_url
    "https://github.com/#{ full_name }"
  end

  def github_updated_at
    time = model[:github_updated_at].present? ? model[:github_updated_at] : 2.years.ago
    time.utc
  end

  # jQuery timeago compatible timestamp
  def timestamp
    github_updated_at.iso8601
  end

  def written_timestamp
    github_updated_at.to_s(:long)
  end

  # CSS classes marking activity
  def activity_class
    case last_updated
      when (-10000)..2.months        then 'very-high'
      when (2.months+1)..6.months    then 'high'
      when (6.months+1)..12.months   then 'medium'
      when (12.months+1)..24.months  then 'low'
      else                                'very-low'
      end
  end
end
