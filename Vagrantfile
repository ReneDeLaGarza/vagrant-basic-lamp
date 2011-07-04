Vagrant::Config.run do |config|
  config.vm.box = "lucid32"
#  config.vm.network("10.10.0.1")
  config.vm.share_folder("v-root", "/vagrant", ".")
  config.vm.forward_port "http",  8080,   8080
  config.vm.forward_port "mysql", 3306, 3306
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe("vagrant_main")
    chef.json.merge!(
          :mysql => {
            :server_root_password => "root"
          },
          :apache => {
            :listen_ports => [ "8080", "443" ]
          },
          :hosts => {
            :localhost_aliases => ["vbox.local"]
          })
  end
end