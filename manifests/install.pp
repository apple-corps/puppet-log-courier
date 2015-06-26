class class_name::install inherits class_name{

  package { 'package_name':
    ensure => $package_ensure,
    name   => $package_name,
  }

}
