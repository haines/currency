desc "Add to Alfred"
task :install => ["install:bundle", :update] do
  ln_sf source_path, install_path
end

namespace :install do
  task :bundle do
    sh %{bundle install --path #{bundle_path} --standalone --without development --clean}
    rm_r bundler_config_path
  end
end

desc "Remove from Alfred"
task :uninstall do
  rm install_path
end

def root_path
  File.expand_path("..", __dir__)
end

def source_path
  File.join(root_path, "workflow")
end

def bundle_path
  File.join(source_path, "bundle")
end

def bundler_config_path
  File.join(root_path, ".bundle")
end

def install_path
  File.join(workflows_root, workflow_id)
end

def workflows_root
  File.expand_path("~/Library/Application Support/Alfred 2/Alfred.alfredpreferences/workflows")
end

def workflow_id
  require "plist"
  Plist.parse_xml(info_plist_path).fetch("bundleid")
end

def info_plist_path
  File.join(source_path, "info.plist")
end

