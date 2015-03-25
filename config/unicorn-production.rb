worker_processes Integer(ENV['WEB_CONCURRENCY'] || 2)
timeout 30
#preload_app true
working_directory "/home/tapster/Demo-Tapster"
pid "/home/tapster/Demo-Tapster/unicorn/unicorn.pid"
stderr_path "/home/tapster/Demo-Tapster/unicorn/unicorn.log"
stdout_path "/home/tapster/Demo-Tapster/unicorn/unicorn.log"
listen "/tmp/unicorn.tapster.sock"
