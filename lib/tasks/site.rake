namespace :site do

  desc "Remove this server from the load balancing / cluster."
  task :enable => :environment do
    FileUtils.rm_f(SITE_LB_SEMAPHORE_FILE)
    puts "Successfully added #{`hostname -s`.chomp} to load balancer registry"
  end

  task :disable => :environment do
    FileUtils.touch(SITE_LB_SEMAPHORE_FILE)
    puts "Successfully removed #{`hostname -s`.chomp} from load balancer registry"
  end

end
