# Load ChefSpec and put our test into ChefSpec mode.
require 'chefspec'

# Describing our recipe. The group name should be the recipe string as you would
# use it with include_recipe.
describe 'apache_cookbook::default' do
  # running on CentOS
  platform 'centos'

  let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'centos', version: '7').converge(described_recipe) }

  it 'installs a yum_package with an install action' do
    expect(chef_run).to install_yum_package('install')
  end
end