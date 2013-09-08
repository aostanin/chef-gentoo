# chef-gentoo

## Description

This cookbook's purpose is to manage Gentoo Linux specific features. It is still somewhat incomplete but better than nothing.

## Usage

### Libraries

#### gentoo_package

This fixes a bug in Chef's portage provider where it fails to install packages when the same package name appears in two different categories (e.g. `dev-db/mysql` and `virtual/mysql`). I couldn't find the bug on Chef's bug tracker again, so maybe it's already fixed.

### Recipes

#### Portage

This recipe is included by default when you add the `gentoo` recipe to the run list. Currently it ensures that all of the `/etc/portage/package.*` directories and the `/etc/portage/patches` directory exists.

### Resources

#### eselect

Runs `eselect x set y`.

##### Example

```ruby
gentoo_eselect "editor" do
  set "/usr/bin/vi"
end
```


#### package_keywords

Adds an entry to the `package.keywords` file.

#### Example

```ruby
packages = [
  "app-admin/chef",
  "app-admin/chef-expander",
  ...
  "www-servers/thin",
]

packages.each do |package|
  gentoo_package_keywords package do
    keywords "~amd64"
  end
end
```

#### package_mask

Adds an entry to the `package.mask` file.

##### Example

```ruby
gentoo_package_mask ">=dev-vcs/git-1.8.0" do
end
```

#### package_unmask

Adds an entry to the `package.unmask` file.

##### Example

```ruby
gentoo_package_unmask "=dev-db/mysql-5.0.96" do
end
```

#### package_use

Adds an entry to the `package.use` file.

##### Example

```ruby
gentoo_package_use "dev-lang/ruby" do
  use "threads"
end
```

#### patch

Adds a patch to `/etc/portage/patches` directory.

## License

Licensed under the Apache License, Version 2.0.

You may find a copy of the license at

```
http://www.apache.org/licenses/LICENSE-2.0
```
