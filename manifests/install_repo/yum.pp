# yum.pp

# Class: fluentd::install_repo::yum ()
#
#
class fluentd::install_repo::yum (
    $key = $fluentd::params::repo_keyurl,
) {
    if ! defined(Class['fluentd']) {
        fail('You must include the fluentd base class before using any fluentd defined resources')
    }

    $repo_desc     = $fluentd::repo_desc
    $repo_gpgcheck = $fluentd::repo_gpgcheck
    $repo_name     = $fluentd::repo_name
    $repo_url      = $fluentd::repo_url

    # Sorry for the different naming of the Repository between debian and redhat.
    # But I dont want rename it to avoid a duplication.
    yumrepo { $repo_name:
        descr    => $repo_desc,
        baseurl  => $repo_url,
        gpgkey   => $key,
        gpgcheck => $repo_gpgcheck,
    }

}
