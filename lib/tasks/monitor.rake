namespace :monitor do

  desc "Remove this server from the load balancing / cluster."
  task :enable => :environment do
    FileUtils.rm_f(MONITOR_LB_SEMAPHORE_FILE)
    puts "Successfully added #{`hostname -s`.chomp} to load balancer registry"
  end

  task :disable => :environment do
    FileUtils.touch(MONITOR_LB_SEMAPHORE_FILE)
    puts "Successfully removed #{`hostname -s`.chomp} from load balancer registry"
  end

end
