# Guardfile
# More info at https://github.com/guard/guard#readme

guard 'minitest' do
  # with Minitest::Spec
  watch(%r|^test/(.*)_test\.rb|)
  # watch(%r|^lib/(.*)([^/]+)\.rb|)       { |m| "test/#{m[1]}#{m[2]}_test.rb" }
  watch(%r|^test/minitest_helper\.rb|)  { "test" }

  # Models
  watch(%r|^app/models/(.*)\.rb|)       { |m| "test/models/#{m[1]}_test.rb" }

  # Helpers
  watch(%r|^app/helpers/(.*)\.rb|)      { |m| "test/helpers/#{m[1]}_test.rb" }

  # Workers
  watch(%r|^app/workers/(.*)\.rb|)      { |m| "test/workers/#{m[1]}_test.rb" }


  # Rails 3.2
  # watch(%r|^app/controllers/(.*)\.rb|) { |m| "test/controllers/#{m[1]}_test.rb" }
end
