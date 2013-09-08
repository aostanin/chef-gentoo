action :create do
  gentoo_package_manage "#{new_resource.name}_use" do
    name new_resource.name
    type "use"
    data new_resource.use
    action :create
  end

  new_resource.updated_by_last_action(false)
end

action :delete do
  gentoo_package_manage "#{new_resource.name}_use" do
    name new_resource.name
    type "use"
    data new_resource.use
    action :delete
  end

  new_resource.updated_by_last_action(false)
end
