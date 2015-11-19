# rex-collectd-base

This package will install rsyslog, and offer to install a number of modules for rsyslog to stream directly to elasticsearch instance(s)

It will not stop logs being logged locally, and will assume some of the configuration for you (queue times, etc). 


##nginx(--server="" [--port=1234])
Adds the config to allow all nginx posts to elasticsearch 

##<h3>syslog(--server="" [--port=1234])
Adds the config to allow all syslog posts to elasticsearch 


```
task "setup", make {

  Rex::Rsyslog::Elastic::setup();
  Rex::Rsyslog::Elastic::syslog(server=>"elasticserver.db.example.com",port=>"9200");
  Rex::Rsyslog::Elastic::nginx(server=>"elasticserver.db.example.com",port=>"9200");

};
```
