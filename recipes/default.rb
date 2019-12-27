#
# Cookbook:: wp-cookbook
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'wp-cookbook::apache'
include_recipe 'wp-cookbook::php' 
include_recipe 'wp-cookbook::mysql'
include_recipe 'wp-cookbook::wp'