require 'spec_helper'

describe 'jenkins-job::default' do
  
  describe service('jenkins') do
    it { should be_enabled }
    it { should be_running }
  end

  it "installs git" do
    expect(command 'which git').to return_stdout /.*\/bin\/git.*/
  end
  
end