class CreateBasicPlatforms < ActiveRecord::Migration
  def up
    basic_platforms = [
      [1, 'Ruby',       'ruby',       'platforms/ruby.png', true],
      [2, 'JavaScript', 'javascript', 'platforms/javascript.png', false],
      [3, 'HTML/CSS',   'html-css',   'platforms/html-css.png', false]
    ]

    basic_platforms.each do |bp|
      Platform.create do |p|
        p.position  = bp[0]
        p.name      = bp[1]
        p.slug      = bp[2]
        p.image_url = bp[3]
        p.default   = bp[4]
      end
    end
  end

  def down
    # Don't do anything
  end
end
