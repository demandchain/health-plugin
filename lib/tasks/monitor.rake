namespace :monitor do

  desc "Remove this server from the load balancing / cluster."
  task :enable => :environment do
    FileUtils.rm_f(HealthPlugin::Config.semaphore_file)
    puts "Successfully added #{`hostname -s`.chomp} to load balancer registry"
  end

  task :disable => :environment do
    FileUtils.touch(HealthPlugin::Config.semaphore_file)
    puts "Successfully removed #{`hostname -s`.chomp} from load balancer registry"
  end

end
