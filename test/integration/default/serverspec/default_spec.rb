require 'spec_helper'

describe 'jenkins-job::default' do
  
  describe service('jenkins') do
    it { should be_enabled }
    it { should be_running }
  end
end