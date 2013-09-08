action :create do
  package_parts = new_resource.package.split("/")

  if new_resource.package.split("/").length == 2
    directory "/etc/portage/patches/#{new_resource.package}" do
      owner "root"
      group "root"
      mode 0755
      recursive true
    end

    cookbook_file "/etc/portage/patches/#{new_resource.package}/#{new_resource.source}" do
      owner "root"
      group "root"
      mode 0644
      source new_resource.source
      cookbook new_resource.cookbook || new_resource.cookbook_name
    end
  else
    Chef::Log.error("#{new_resource.package} is not a valid package")
  end

  new_resource.updated_by_last_action(false)
end

action :delete do
  cookbook_file "/etc/portage/patches/#{new_resource.package}/#{new_resource.source}" do
    action :delete
  end

  new_resource.updated_by_last_action(false)
end
