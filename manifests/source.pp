# == definition fluentd::source
define fluentd::source (
    $configfile,
    $type,
    $tag          = false,
    $format       = false,
    $time_format  = false,
    $config       = {},
    $pattern      = [],
) {

    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    concat::fragment { "source_${title}":
        target  => "${fluentd::config_dir}/config.d/${configfile}.conf",
        require => Package["${fluentd::package_name}"],
        content => template('fluentd/source.erb'),
    }
}
