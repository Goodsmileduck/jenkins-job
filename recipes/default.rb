#
# Cookbook Name:: jenkins-job
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'jenkins::java'

include_recipe 'jenkins::master'