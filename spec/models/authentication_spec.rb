# == Schema Information
#
# Table name: authentications
#
#  created_at :datetime         not null
#  id         :integer          not null, primary key
#  provider   :text             not null
#  uid        :text             not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

require 'spec_helper'

describe Authentication do
  subject { Fabricate.build(:authentication) }
  it { should be_valid }

  it { should belong_to(:user) }
  it { should validate_presence_of(:user) }

  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }
end
