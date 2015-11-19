package Rex::Rsyslog::Elastic; 
use Rex -base;
use Rex::Ext::ParamLookup;

# Usage: rex setup (Install rsyslog-elasticsearch logging)
# Usage: rex syslog (stream syslog to elasticsearch)
# Usage: rex nginx (stream nginx logs to elasticsearch) 

desc 'Set up collectd';
task 'setup', sub { 

	pkg "rsyslog",
		ensure => "installed",
		on_change => sub {
			say "package installed";
			service rsyslog => "restart";
		};

	service rsyslog => ensure => "started";
};

desc 'Syslog to elasticsearch';
task 'syslog', sub {

	unless ( is_installed("rsyslog") ) {
    		Rex::Logger::info "pkg rsyslog not detected on this node. Aborting", 'error';
		return;
   	}

	unless ( param_lookup("server") ) {
    		Rex::Logger::info "--server parameter requied. Aborting", 'error';
		return;
   	}

	my $server = param_lookup "server";
	my $port   = param_lookup "port", "9200";

	file "/etc/rsyslog.d/es-syslog.conf",
		content => template("files/etc/rsyslog.d/es-syslog.tmpl", es => { server => "$server", port => "$port" }),
		on_change => sub { 
			say "Config updated. Restarting rsyslog";
			service rsyslog => "restart";
			}
};

desc 'Nginx to elasticsearch';
task 'nginx', sub {

	unless ( is_installed("rsyslog") ) {
    		Rex::Logger::info "pkg rsyslog not detected on this node. Aborting", 'error';
		return;
   	}

	unless ( param_lookup("server") ) {
    		Rex::Logger::info "--server parameter requied. Aborting", 'error';
		return;
   	}

	my $server = param_lookup "server";
	my $port   = param_lookup "port", "9200";

	file "/etc/rsyslog.d/es-nginx.conf",
		content => template("files/etc/rsyslog.d/es-nginx.tmpl", es => { server => "$server", port => "$port" }),
		on_change => sub { 
			say "Config updated. Restarting rsyslog";
			service rsyslog => "restart";
			}
};


desc 'Remove plugin';
task 'remove', sub {

	Rex::Logger::info "Coming soon. ",'error';
}
