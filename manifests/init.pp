
class class_name (
      $autoupgrade       = $class_name::params::autoupgrade,
      $config            = undef,
      $config_template   = undef,
      $ssl_ca            = undef,
      $package_ensure    = $class_name::params::package_ensure,
      $package_name      = $class_name::params::package_name,
      $servers           = $class_name::params::servers,
      $service_enable    = $class_name::params::service_enable,
      $service_ensure    = $class_name::params::service_ensure,
      $service_manage    = $class_name::params::service_manage,
      $service_name      = $class_name::params::service_name,
    ) inherits class_name::params {

      validate_absolute_path($config)
      validate_string($config_template)
      validate_string($package_ensure)
      validate_bool($package_manage)
      validate_array($package_name)
      validate_array($servers)
      validate_bool($service_enable)
      validate_string($service_ensure)
      validate_bool($service_manage)
      validate_string($service_name)
    
      }
    
      # Anchor this as per #8040 - this ensures that classes won't float off and
      # mess everything up.  You can read about this at:
      # http://docs.puppetlabs.com/puppet/2.7/reference/lang_containment.html#known-issues
      anchor { 'class_name::begin': } ->
      class { '::class_name::install': } ->
      class { '::class_name::config': } ~>
      class { '::class_name::service': } ->
      anchor { 'class_name::end': }
    
    }
