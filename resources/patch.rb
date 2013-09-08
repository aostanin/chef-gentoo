actions :create, :delete
default_action :create

attribute :name,
  :name_attribute => true,
  :kind_of        => String

attribute :package,
  :kind_of  => String,
  :required => true

attribute :source,
  :kind_of  => String,
  :required => true

attribute :cookbook,
  :kind_of => String
