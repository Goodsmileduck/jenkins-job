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
include_recipe "jenkins-job-builder"
#include_recipe "python::pip"
include_recipe 'git'
jenkins_plugin "scm-api"
jenkins_plugin "git-client"
jenkins_plugin "git"
jenkins_plugin 'job-dsl'

python_pip "wheel" do
  action :install
end

if platform_family?('rhel')
  include_recipe 'yum-epel'
end

yum_package 'libyaml-devel' do
  action :install
end

yum_package 'rpm-build' do
	action :install
end

jenkins_plugin 'job-dsl' do 
	notifies :restart, 'service[jenkins]', :immediately	
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

template '/etc/jenkins_jobs/jenkins-job-builder.yaml' do
  source "jenkins-job-builder.yaml"
end

build_jenkins_job 'jenkins-job-builder' do
  job_config '/etc/jenkins_jobs/'
end