# == class fluentd
class fluentd (
    $config_dir       = $fluentd::params::config_dir,
    $config_group     = $fluentd::params::config_group,
    $config_owner     = $fluentd::params::config_owner,
    $install_repo     = $fluentd::params::install_repo,
    $package_ensure   = $fluentd::params::package_ensure,
    $package_name     = $fluentd::params::package_name,
    $repo_desc        = $fluentd::params::repo_desc,
    $repo_gpgcheck    = $fluentd::params::repo_gpgcheck,
    $repo_include_src = $fluentd::params::repo_include_src,
    $repo_keyurl      = $fluentd::params::repo_keyurl,
    $repo_name        = $fluentd::params::repo_name,
    $repo_release     = $fluentd::params::repo_release,
    $repo_repos       = $fluentd::params::repo_repos,
    $repo_tdkey       = $fluentd::params::repo_tdkey,
    $repo_url         = $fluentd::params::repo_url,
    $service_enable   = $fluentd::params::service_enable,
    $service_ensure   = $fluentd::params::service_ensure,
    $version          = '1',
) inherits fluentd::params {
    class{'fluentd::packages': }
    class{'fluentd::config': }
    class{'fluentd::service': }

    validate_bool($install_repo, $service_enable)

    Class['Fluentd::Packages'] -> Class['Fluentd::Config'] -> Class['Fluentd::Service']
}
