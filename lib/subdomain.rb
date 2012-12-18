# Returns true if the request's subdomains is equal to a known language slug
# else returns false
class Subdomain
  def self.matches?(request)
    case request.subdomain.downcase.strip
    when /#{ Language::All.join('|') }|js/i
      true
    else
      false
    end
  end
end
