action :create do
  gentoo_package_manage "#{new_resource.name}_unmask" do
    name new_resource.name
    data []
    type "unmask"
    action :create
  end

  new_resource.updated_by_last_action(false)
end

action :delete do
  gentoo_package_manage "#{new_resource.name}_unmask" do
    name new_resource.name
    data []
    type "unmask"
    action :delete
  end

  new_resource.updated_by_last_action(false)
end
