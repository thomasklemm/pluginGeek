GITHUB_URL_REGEXP = /https:\/\/github.com\/(?<owner_and_name>[\w|.]+\/[\w|.]+)/
PLATFORMS = [
  { id: :ruby, name: 'Ruby' },
  { id: :javascript, name: 'JavaScript' }
]
PLATFORM_IDS = PLATFORMS.map { |platform| platform[:id] }
PLATFORM_IDS_REGEXP = /(#{PLATFORM_IDS.join('|')})/i
REPO_OWNER_AND_NAME_REGEXP = /[\w|\-|.]+\/[\w|\-|.]+/


