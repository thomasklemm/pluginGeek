require 'minitest_helper'

REPO_ATTRIBUTES = {
  :success => {
    :full_name => 'rails/rails',
    :category_list => 'Web Application Frameworks (Ruby)',
    :label => 'Must have!'
  },
  :failure => {
    :name => 'rails',
    :owner => 'rails',
    :description => 'Testing to assign description',
    :cached_category_list => 'Web Application Frameworks (Ruby)'
  }
}

describe Repo do
  describe "when initialized with mass-assignment" do

    REPO_ATTRIBUTES.each do |status, attributes|
      case status
      when :success

        attributes.each do |field, value|
          it "must accept attribute #{field}" do
            repo = Repo.new(field => value)
            # Validations may still fail,
            # but no error must be raised
            [true, false].must_include repo.save
          end
        end

      when :failure

        attributes.each do |field, value|
          it "wont accept attribute #{field}" do
            begin
              repo = Repo.new(field => value)
            rescue ActiveModel::MassAssignmentSecurity::Error
              repo.must_equal nil
            end
          end
        end

      else puts 'An invalid status has been assigned.'
      end
    end

  end
end
