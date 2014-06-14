GITHUB_URL_REGEXP = /https:\/\/github.com\/(?<owner_and_name>[\w|.]+\/[\w|.]+)/
PLATFORM_SLUGS = Platform.all.map(&:slug)
PLATFORM_SLUGS_REGEXP = /(#{PLATFORM_SLUGS.join('|')})/i
REPO_OWNER_AND_NAME_REGEXP = /[\w|\-|.]+\/[\w|\-|.]+/
