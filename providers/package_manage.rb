action :create do
  check_files
  data = parse_file
  updated = false

  new_data = new_resource.data
  if new_data.class <= String
    new_data = new_data.split(" ")
  end

  if data.has_key?(new_resource.name)
    if data[new_resource.name].proper_superset?(new_data.to_set)
      data[new_resource.name] = data[new_resource.name].merge(new_data)
    end
  else
    data[new_resource.name] = new_data.to_set
    updated = true
  end

  if updated
    save_file(data)
    Chef::Log.info("Added #{new_resource.type} flags (#{new_data.join(", ")}) for #{new_resource.name}")
    new_resource.updated_by_last_action(true)
  end
end

action :delete do
  check_files
  data = parse_file
  updated = false

  new_data = new_resource.data
  if new_data.class <= String
    new_data = new_data.split(" ")
  end

  if data.has_key?(new_resource.name)
    if data[new_resource.name].intersection(new_data).length > 0
      data[new_resource.name] = data[new_resource.name].subtract(new_data)
      updated = true
    end
    if data[new_resource.name].length == 0
      data.delete(new_resource.name)
      updated = true
    end
  end

  if updated
    save_file(data)
    Chef::Log.info("Removed #{new_resource.type} flags (#{new_data.join(", ")}) for #{new_resource.name}")
    new_resource.updated_by_last_action(true)
  end
end

protected

def portage_path
  "/etc/portage"
end

def check_files
  if !::File.directory?("#{portage_path}/package.#{new_resource.type}")
    raise Chef::Exceptions::ResourceNotFound, "Could not find #{portage_path}/package.#{new_resource.type} directory"
  end

  if !::File.file?("#{portage_path}/package.#{new_resource.type}/default")
    raise Chef::Exceptions::ResourceNotFound, "Could not find #{portage_path}/package.#{new_resource.type}/default file"
  end
end

def parse_file
  data = {}
  ::File.open("#{portage_path}/package.#{new_resource.type}/default").each_line do |line|
    parts = line.split(" ")
    if parts.length > 0
      data[parts[0]] = parts[1,parts.length].to_set
    end
  end
  data
end

def save_file(data)
  ::File.open("#{portage_path}/package.#{new_resource.type}/default", 'w') do |file|
    data.each do |key, value|
      file.puts("#{key} #{value.to_a.join(" ")}")
    end
  end
end
