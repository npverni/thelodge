require 'mongrel_cluster/recipes'
default_run_options[:pty] = true
 
set :application, "thelodge"

set :repository, "git@github.com:npverni/thelodge.git"
#set :branch, "master"
 
set :scm, "git"
set :scm_passphrase, "d3p77r"
set :password, "d3p77r" 

set :user, "deploy"
set :runner, "deploy"
 
role :app,  "thelodge.blenderbox.com"
role :web,  "thelodge.blenderbox.com"
role :db,   "thelodge.blenderbox.com", :primary => true
 
set :deploy_via, :export
 
set :deploy_to, "/home/www/thelodge/capapp"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"


set :branch, "master"


desc "Do Custom Symlinks and move config files"
namespace :compost do
  task :do_custom_symlinks do
    ['database.yml', 'juggernaut.yml','juggernaut_hosts.yml'].each do |file|
      run "cp #{deploy_to}/#{shared_dir}/config/#{file} #{current_release}/config/#{file}"
    end
    run "ln -nfs #{deploy_to}/shared/avatars #{release_path}/public/avatars"
  end
end
after "deploy:symlink", "compost:do_custom_symlinks"