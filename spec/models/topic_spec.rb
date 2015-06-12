require 'rails_helper'

describe Topic do
  describe "scopes" do

    before do
      @public_topic  = Topic.create
      @private_topic = Topic.create(public: false)
      @topics_count  = Topic.all.count
    end

    describe "publicly_viewable" do
      it "returns a relation of all public topics" do
        expect(Topic.publicly_viewable).to eq( [@public_topic] )
      end
    end

    describe "privately_viewable" do
      it "returns a relation of all private topics" do
        expect(Topic.privately_viewable).to eq( [@private_topic] )
      end
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        u = true # sneaky solution; we don't need a real user, just something truthy
        topic_size = Topic.visible_to(u).count
        expect(topic_size).to eq(@topics_count)
      end

      it "returns only public topics if user is nil" do
        user = nil
        expect(Topic.visible_to(user).count).to be < @topics_count
      end
    end

  end
end