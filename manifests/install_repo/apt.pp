##apt.pp

# Class: fluentd::install_repo::apt ()
#
#
class fluentd::install_repo::apt () {

    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    $repo_include_src = $fluentd::repo_include_src
    $repo_name        = $fluentd::repo_name
    $repo_release     = $fluentd::repo_release
    $repo_repos       = $fluentd::repo_repos
    $repo_tdkey       = $fluentd::repo_tdkey
    $repo_url         = $fluentd::repo_url

    apt::source { $repo_name:
        location    => $repo_url,
        release     => $repo_release,
        repos       => $repo_repos,
        include_src => $repo_include_src,
    }

    if $repo_tdkey {
        file { '/tmp/packages.treasure-data.com.key':
            ensure => file,
            source => 'puppet:///modules/fluentd/packages.treasure-data.com.key'
        }->
        exec { "import gpg key Treasure Data":
            command => "/bin/cat /tmp/packages.treasure-data.com.key | apt-key add -",
            unless  => "/usr/bin/apt-key list | grep -q 'Treasure Data'",
            notify  => Class['::apt::update'],
        }
    }
}
