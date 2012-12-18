class CreateLanguageStructure < ActiveRecord::Migration
  def up
    # Manually destroy every language to destroy hierarchies in related table, too
    Language.all.each { |lang| lang.destroy }

    # Create static language hierarchy
    web = Language.create(name: 'Web')
    web.children << Language.create(name: 'Ruby')
    web.children << Language.create(name: 'Javascript')
    web.children << Language.create(name: 'Webdesign')
    web.children << Language.create(name: 'Python')
    web.children << Language.create(name: 'PHP')
    web.children << Language.create(name: 'Scala')
    web.children << Language.create(name: 'Go')

    mobile = Language.create(name: 'Mobile')
    mobile.children << Language.create(name: 'iOS')
    mobile.children << Language.create(name: 'Android')

    puts 'Added static languages hierarchy'
  end

  def down
    # Manually destroy every language to destroy hierarchies in related table, too
    Language.all.each { |lang| lang.destroy }
  end
end
