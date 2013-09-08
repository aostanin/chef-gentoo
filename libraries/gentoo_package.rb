require 'chef/provider/package'
require 'chef/resource/package'
require 'chef/platform'
require 'chef/mixin/shell_out'

class Chef
  class Provider
    class Package
      class Gentoo < Chef::Provider::Package::Portage
        include Chef::Mixin::ShellOut

        def parse_emerge(package, txt)
          availables = {}
          category, package_without_category = %r{^#{PACKAGE_NAME_PATTERN}$}.match(@new_resource.package_name)[1,2]
          found_package_name = nil

          txt.each_line do |line|
            if line =~ /\*\s+(#{PACKAGE_NAME_PATTERN})/
              found_package_name = $1.strip
              if category
                availables[found_package_name] = nil if found_package_name == package
              else
                availables[found_package_name] = nil if found_package_name.split("/").last == package_without_category
              end
            end

            if line =~ /Latest version available: (.*)/ && availables.has_key?(found_package_name)
              availables[found_package_name] = $1.strip
            end
          end

          if availables.size > 1
            # shouldn't happen if a category is specified so just use `package`
            raise Chef::Exceptions::Package, "Multiple emerge results found for #{package}: #{availables.keys.join(" ")}. Specify a category."
          end

          availables.values.first
        end
      end
    end
  end
end

Chef::Platform.set :platform => :gentoo, :resource => :package, :provider => Chef::Provider::Package::Gentoo
