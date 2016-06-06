# == fluentd::install_plugin::file
#
# install a plugin with by copying a file to /etc/td-agent/plugins
#
# Parameters:
#  the name of this ressource reflects the filename of the plugin, which must
#  be copied to fluentd/files
#
#  ensure:      "present"(default) or "absent", install or uninstall a plugin
#
define fluentd::install_plugin::file (
    $ensure      = 'present',
    $plugin_name = $name,
) {

    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    file { "${fluentd::config_dir}/plugin/${plugin_name}":
        ensure => $ensure,
        owner  => $fluentd::config_owner,
        group  => $fluentd::config_group,
        mode   => '0640',
        source => "puppet:///fluentd/plugins/${plugin_name}",
        notify => Service[$fluentd::service_name],
    }
}
