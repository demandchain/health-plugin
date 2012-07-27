DEPLOYED_IDENT = (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
DEPLOYED_BRANCH = (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
DEPLOYED_ENV = Rails.env

describe = %x(git describe 2>/dev/null).chomp
DEPLOYED_DESCRIBE = (describe.present? ? describe : "N/A")

timestamp = %x(git log -1 --pretty=format:"%aD" 2>/dev/null).chomp
DEPLOYED_TIMESTAMP = (timestamp.present? ? timestamp : "N/A")

MONITOR_PONG = 'pong'
MONITOR_PANG = 'pang'

MONITOR_LB_SEMAPHORE_FILE = File.join(Rails.root, ".disabled")
