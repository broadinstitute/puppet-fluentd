# == definition fluentd::configfile
define fluentd::configfile  {
    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    $source_conf = "${fluentd::config_dir}/config.d/${title}.conf"

    concat{$source_conf:
        owner   => $fluentd::config_owner,
        group   => $fluentd::config_group,
        mode    => '0644',
        require => Class['Fluentd::Packages'],
        notify  => Class['Fluentd::Service'],
    }
}
