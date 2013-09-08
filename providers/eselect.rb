action :create do
  if current_value(new_resource.name) != new_resource.set
    set_value(new_resource.name, new_resource.set)
    Chef::Log.info("Set eselect module #{new_resource.name} to #{new_resource.set}")
    new_resource.updated_by_last_action(true)
  end
end

protected

def current_value(mod)
  %x{/usr/bin/eselect --brief --no-color #{mod} show}.strip
end

def set_value(mod, value)
  %x{/usr/bin/eselect #{mod} set #{value}}
end
