require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        invalid_vote = Vote.new({value: 2})
        expect(invalid_vote.valid?).to eq(false)
      end

      it "only allows 1" do
        valid_vote = Vote.new({value: 1})
        expect(valid_vote.valid?).to eq(true)
      end

      it "only allows -1" do
        valid_vote = Vote.new({value: -1})
        expect(valid_vote.valid?).to eq(true)
      end

    end
  end
end