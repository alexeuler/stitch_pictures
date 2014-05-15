require 'daemons'
require_relative "application"
dir=File.expand_path("../", File.dirname(__FILE__))

Daemons.run_proc('api_daemon', {
    dir_mode: :normal,
    dir: "#{dir}/log",
    backtrace: true,
    monitor: true,
    log_output: true
}) do
  app = Application.new
  app.run
  puts "Done"
end