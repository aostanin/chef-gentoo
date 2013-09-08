action :create do
  gentoo_package_manage "#{new_resource.name}_keywords" do
    name new_resource.name
    type "keywords"
    data new_resource.keywords
    action :create
  end

  new_resource.updated_by_last_action(false)
end

action :delete do
  gentoo_package_manage "#{new_resource.name}_keywords" do
    name new_resource.name
    type "keywords"
    data new_resource.keywords
    action :delete
  end

  new_resource.updated_by_last_action(false)
end
