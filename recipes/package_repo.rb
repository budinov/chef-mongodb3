#
# Cookbook Name:: mongodb3
# Recipe:: package_repo
#
# Copyright 2015, Sunggun Yu
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Add the MongoDB 3.0 Package repository
case node['platform_family']
  when 'rhel', 'fedora'
    yum_repository 'mongodb-org-3.0' do
      description 'MongoDB Repository'
      baseurl "https://repo.mongodb.org/yum/redhat/6/mongodb-org/3.0/#{node['kernel']['machine'] =~ /x86_64/ ? 'x86_64' : 'i686'}"
      action :create
      gpgcheck false
      enabled true
    end
  when 'debian'
    apt_repository 'mongodb' do
      uri 'http://repo.mongodb.org/apt/ubuntu'
      distribution "#{node['lsb']['codename']}/mongodb-org/stable"
      components ['multiverse']
      keyserver 'hkp://keyserver.ubuntu.com:80'
      key '7F0CEB10'
      action :add
    end
    include_recipe 'apt'
end
