class class_name::params {

  #### Default values for the parameters of the main module class, init.pp

  # ensure
  $ensure = 'present'

  # autoupgrade
  $autoupgrade = false

  # service status
  $status = 'enabled'

  # restart on configuration change?
  $restart_on_change = true

  # Purge configuration directory
  $purge_configdir = true

  # init defaults
  $init_defaults = undef

  $purge_package_dir = false

  # Exec timeout
  $package_dl_timeout = 300  # 300 seconds is default of Puppet

  #### Internal module values

  # User and Group for the files and user to run the service as.
  case $::kernel {
    'Linux': {
      $class_name_user= 'root'
      $class_name_group = 'root'
    }
    'Darwin': {
      $class_name_user  = 'root'
      $class_name_group = 'wheel'
    }
    default: {
      fail("\"${module_name}\" provides no user/group default value
           for \"${::kernel}\"")
    }
  }

  # Download tool
  case $::kernel {
    'Linux': {
      $download_tool = 'wget -O'
    }
    'Darwin': {
      $download_tool = 'curl -o'
    }
    default: {
      fail("\"${module_name}\" provides no download tool default value
           for \"${::kernel}\"")
    }
  }

  # Different path definitions
  case $::kernel {
    'Linux': {
      $configdir = '/etc/path'
      $package_dir = '/opt/path/path'
      $installpath = '/opt/path'
    }
    'Darwin': {
      $configdir = '/Library/Application Support/path'
      $package_dir = '/Library/path/path'
      $installpath = '/Library/path'
    }
    default: {
      fail("\"${module_name}\" provides no config directory default value
           for \"${::kernel}\"")
    }
  }

  # packages
  case $::operatingsystem {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux': {
      # main application
      $package = [ 'package-name' ]
    }
    'Debian', 'Ubuntu': {
      # main application
      $package = [ 'package-name' ]
    }
    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }

  # service parameters
  case $::operatingsystem {
    'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon', 'OracleLinux': {
      $service_name       = 'service-name'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
      $service_providers  = [ 'init' ]
      $defaults_location  = '/etc/sysconfig'
    }
    'Debian', 'Ubuntu': {
      $service_name       = 'service-name'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
      $service_providers  = [ 'init' ]
      $defaults_location  = '/etc/default'
    }
    'Darwin': {
      $service_name       = 'net.service.name'
      $service_hasrestart = true
      $service_hasstatus  = true
      $service_pattern    = $service_name
      $service_providers  = [ 'launchd' ]
      $defaults_location  = false
    }
    default: {
      fail("\"${module_name}\" provides no service parameters
            for \"${::operatingsystem}\"")
    }
  }

}
