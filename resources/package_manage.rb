actions :create, :delete
default_action :create

attribute :name,
  :name_attribute => true,
  :kind_of        => String,
  :regex          => [
    /\w+-\w+\/(\w|-)+/,
    /(<|>)?(=)?\w+-\w+\/(\w|-|\.)+/
  ]

attribute :type,
  :kind_of => String,
  :regex    => [
    /keywords/,
    /mask/,
    /unmask/,
    /use/
  ]

attribute :data,
  :kind_of => [ String, Array ]
