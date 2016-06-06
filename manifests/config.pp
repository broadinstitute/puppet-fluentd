# Class: fluentd::config()
#
#
class fluentd::config() {
    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    file { "${fluentd::config_dir}/td-agent.conf" :
        ensure  => file,
        owner   => 'root',
        group   => 'root',
        content => template('fluentd/td-agent.conf.erb'),
        notify  => Class['fluentd::service'],
    }

    file { "${fluentd::config_dir}/config.d":
        ensure => 'directory',
        owner  => $fluentd::config_owner,
        group  => $fluentd::config_group,
        mode   => '0750',
    }
}
