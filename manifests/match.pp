# == definition fluentd::match
define fluentd::match (
    $configfile,
    $type,
    $pattern,
    $config   = {},
    $servers  = [],
    $order    = undef,
) {

    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    concat::fragment { "match_${title}":
        target  => "${fluentd::config_dir}/config.d/${configfile}.conf",
        require => Package["${fluentd::package_name}"],
        content => template('fluentd/match.erb'),
        order   => $order,
    }
}
