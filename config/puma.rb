# Change to match your CPU core count
workers 4

# Min and Max threads per worker
threads 1, 6

# # app_dir = File.expand_path("../..", __FILE__)
# # shared_dir = "#{app_dir}/shared"

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Bind the server to "url". "tcp://", "unix://" and "ssl://" are the only
# accepted protocols.
#
# The default is "tcp://0.0.0.0:9292".
#
bind 'tcp://0.0.0.0:3000'
# bind 'unix:///var/run/puma.sock'
# bind 'unix:///var/run/puma.sock?umask=0111'
# bind 'ssl://127.0.0.1:9292?key=path_to_key&cert=path_to_cert'

# # # Set up socket location
# # bind "unix://#{shared_dir}/sockets/puma.sock"

# # Set master PID and state locations
# # pidfile "#{shared_dir}/pids/puma.pid"
# # state_path "#{shared_dir}/pids/puma.state"
# activate_control_app

# on_worker_boot do
#   require "active_record"
#   ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#   ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
# end