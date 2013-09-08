actions :create, :delete
default_action :create

attribute :name,
  :name_attribute => true,
  :kind_of        => String

attribute :use,
  :kind_of => [ String, Array ]
