class consul::install {
	file { "/var/local/consul":
		ensure => directory,
		mode   => "0730",
		owner  => "root",
		group  => "consul",
	}

	group { "consul": ensure => present }
	user { "consul": gid => "consul" }

	# Fuck I hate people who don't provide decent packages
	file { "/usr/local/bin/install-consul":
		ensure => file,
		source => "puppet:///modules/consul/usr/local/bin/install-consul",
		mode   => "0555",
		owner  => "root",
		group  => "root",
	}

	ensure_packages("unzip", { ensure => present })

	exec { "download and install consul":
		command => "/usr/local/bin/install-consul",
		creates => "/usr/local/bin/consul",
		require => Package["unzip"],
	}
}
