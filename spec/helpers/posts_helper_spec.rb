require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the PostsHelper. For example:
#
# describe PostsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe PostsHelper, type: :helper do
  pending "add some examples to (or delete) #{__FILE__}"
end

RSpec.describe PostsHelper, type: :helper do
  describe '#format_date' do
    it 'formats the date correctly' do
      date = Time.zone.parse('2023-06-20')
      formatted_date = helper.format_date(date)
      expect(formatted_date).to eq('June 20, 2023')
    end
  end
end

