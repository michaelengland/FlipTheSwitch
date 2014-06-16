require 'spec_helper'

describe FlipTheSwitch::Test do
  subject(:test) { described_class }

  it { should be_yes }
  it { should_not be_no }
end
