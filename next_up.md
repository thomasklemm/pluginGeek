production backup
development restore production
run migrations and see if they work so far

g push origin develop

create platforms and platform_categories
don't define platforms in code

add compound indexes (right name?) for join tables

Platform
  1: id - primary key
  Ruby: name - text, null: false, validates presence
  ruby: slug - text, null: false, validates presence
  1: position - integer, null: false

  has_many :categories,
    -> { order_by_name },
    through: :platform_categories
  has_many :platform_categories

PlatformCategory
  belongs_to :platform
  belongs_to :category
