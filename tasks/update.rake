desc "Updates the workflow with commands for preferred currencies"
task :update do
  require_relative "updater"
  Updater.update
end
