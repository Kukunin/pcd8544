require 'spec_helper'

RSpec.describe "Pcd8544::ASCII" do
  it "contains ascii chart" do
    expect(Pcd8544::ASCII).to be_a Array
    expect(Pcd8544::ASCII.count).to eq 96
  end
end
