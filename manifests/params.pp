# Class: fluentd::params
#
#
class fluentd::params {
    $config_dir     = '/etc/td-agent'
    $config_group   = 'td-agent'
    $config_owner   = 'td-agent'
    $package_name   = 'td-agent'
    $package_ensure = 'installed'
    $install_repo   = true
    $service_ensure = 'running'
    $service_enable = true
    $service_name   = 'td-agent'

    case $::osfamily {
        'redhat': {
            $repo_desc        = 'Treasure Data'
            $repo_gpgcheck    = true
            $repo_include_src = undef
            $repo_keyurl      = 'http://packages.treasuredata.com/redhat/RPM-GPG-KEY-td-agent'
            $repo_name        = 'treasuredata'
            $repo_release     = undef
            $repo_repos       = undef
            $repo_tdkey       = false
            $repo_url         = 'http://packages.treasuredata.com/redhat/$basearch'

            class{'fluentd::install_repo::yum':
                before => Package[$package_name],
            }
        }
        'debian': {
            $repo_desc        = undef
            $repo_gpgcheck    = undef
            $repo_include_src = false
            $repo_keyurl      = undef
            $repo_name        = 'treasure-data'
            $repo_release     = 'lucid'
            $repo_repos       = 'contrib'
            $repo_tdkey       = true
            $repo_url         = 'http://packages.treasuredata.com/debian'

            class{'fluentd::install_repo::apt':
                before => Package[$package_name],
            }
        }
        default: {
            fail("Unsupported osfamily ${::osfamily}")
        }
    }
}