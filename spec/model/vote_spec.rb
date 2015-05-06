require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allow -1 or 1 as values" do
        expect( @vote ).to eq([-1,1])
      end
    end
  end
end