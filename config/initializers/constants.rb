PLATFORMS = [
  { id: :ruby, name: 'Ruby' },
  { id: :javascript, name: 'JavaScript' },
  { id: :html_css, name: 'HTML/CSS'},
  { id: :ios, name: 'iOS' },
  { id: :android, name: 'Android' }
]
PLATFORM_IDS = PLATFORMS.map { |platform| platform[:id] }
PLATFORM_IDS_REGEXP = /(#{ PLATFORM_IDS.join('|') })/i

GITHUB_URL_REGEXP = /https:\/\/github.com\/(?<owner_and_name>[\w|.]+\/[\w|.]+)/
REPO_OWNER_AND_NAME_REGEXP = /[\w|\-|.]+\/[\w|\-|.]+/
