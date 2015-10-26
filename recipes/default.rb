#
# Cookbook Name:: jenkins-job
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#include_recipe 'yum'
include_recipe 'jenkins::java'
include_recipe 'jenkins::master'
include_recipe 'python'
jenkins_plugin "scm-api"
jenkins_plugin "git-client"
jenkins_plugin "git"


yaml = value_for_platform_family({
  ['debian'] => 'libyaml-dev',
  ['rhel','fedora','suse'] => 'libyaml-devel'
})

if platform_family?('rhel')
  include_recipe 'yum-epel'
end

package yaml do
  action :install
end

unless node['jenkins_job_builder']['from_source']
  python_pip 'jenkins-job-builder' do
    version node['jenkins_job_builder']['version']
    action :install
  end
else
  python_pip node['jenkins_job_builder']['repo'] do
    action :install
  end
end

directory '/etc/jenkins_jobs' do
  owner node['jenkins_job_builder']['user']
  group node['jenkins_job_builder']['group']
  mode '0750'
end

template '/etc/jenkins_jobs/jenkins_jobs.ini' do
  source 'jenkins_jobs.ini.erb'
  owner node['jenkins_job_builder']['user']
  group node['jenkins_job_builder']['group']
  mode '0640'
  variables({
    :username => node['jenkins_job_builder']['username'],
    :password => node['jenkins_job_builder']['password'],
    :url => node['jenkins_job_builder']['url']
  })
end
