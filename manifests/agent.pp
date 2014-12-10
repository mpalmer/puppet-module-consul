define consul::agent(
		$server         = false,
		$dc             = "dc1",
		$join           = undef,
		$client_address = "127.0.0.1",
		$expect         = undef,
) {
	include consul::install

	file { "/var/local/consul/${name}":
		ensure => directory,
		mode   => 0700,
		owner  => "consul",
		group  => "consul",
	}

	if $server {
		if $expect == undef {
			fail "I don't know how many servers to expect"
		}
		
		$server_opt = " -server -bootstrap-expect=$expect"
	} else {
		$server_opt = ""
	}

	if $join {
		$join_opt = " -retry-join=$join"
	} else {
		$join_opt = ""
	}

	daemontools::service { "consul-${name}":
		command => "/usr/local/bin/consul agent${server_opt}${join_opt} -client=${client_address} -node=${name} -dc=${dc} -data-dir=/var/local/consul/${name} -pid-file=/var/local/consul/${name}.pid",
		user    => "consul",
		require => File["/var/local/consul/${name}"],
		environment => {
			"GOMAXPROCS" => "2",
		}
	}
}
