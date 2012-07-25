SITE_SHA = (IO.read(File.join(Rails.root, "REVISION")) rescue "N/A")
SITE_BRANCH = (IO.read(File.join(Rails.root, "BRANCH")) rescue "N/A")
SITE_ENV = Rails.env
SITE_PONG = 'pong'
SITE_PANG = 'pang'

SITE_LB_SEMAPHORE_FILE = File.join(Rails.root, ".disabled")
