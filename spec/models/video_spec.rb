require 'rails_helper'

RSpec.describe Video do
  it {should belong_to :tutorial}
  it {should have_many(:users).through(:user_videos)}
  it {should have_many(:user_videos).dependent(:destroy)}
  it {should validate_presence_of :tutorial_id}

  it "if a tutorial is deleted, videos are deleted" do
    tutorial1 = create(:tutorial)
    video0 = create(:video, title: "v1", tutorial: tutorial1)
    video1 = create(:video, title: "v2", tutorial: tutorial1)
    video2 = create(:video, title: "v3", tutorial: tutorial1)

    expect(tutorial1.videos.length).to eq(3)
    expect(Tutorial.all.length).to eq(1)
    expect(Video.all.length).to eq(3)

    Tutorial.destroy(tutorial1.id)

    expect(Tutorial.all.length).to eq(0)
    expect(Video.all.length).to eq(0)
  end
  
end
