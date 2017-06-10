require_relative 'boot'
require_relative 'environment'
require 'clockwork'

include Clockwork

# every(1.minute, 'status.checker')  { StatusCheckerJob.perform_later }
