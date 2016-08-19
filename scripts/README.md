lame quality scripts I sometimes use because the yak likes hairy:

* scripts/haproxy-stats-collector - sum all proxy counters and print them out in collectd friendly format. works for nbproc>=1
* scripts/cligraph - buggy counter derivative calculator and "pretty" printing in terminal:  while true; do mysql -h 127.0.0.1 -e 'show processlist' | wc -l | ./cligraph; sleep 1; done
* scripts/haproxy-logs-analyze - analyze haproxy error logs for http mode proxies (option dontlog-normal, option log-separate-errors, option httplog)
* scripts/db_map - given a list of mysql database host names and a list of virtual hostnames/IPs (dbv) bound to the db servers , generate a replication topology map using graphviz
* scripts/git-hook-jenkins-build - git hook to trigger a jenkins build after receiving a push. the build configuration is selected based on the branch.
* scripts/s3-audio-index.pl - generate an html5 file with links to audio files stored in S3 
