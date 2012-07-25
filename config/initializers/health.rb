MONITOR_IDENT = (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
MONITOR_BRANCH = (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
MONITOR_ENV = Rails.env
MONITOR_PONG = 'pong'
MONITOR_PANG = 'pang'

MONITOR_LB_SEMAPHORE_FILE = File.join(Rails.root, ".disabled")
