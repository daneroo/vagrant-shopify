
Vagrant::Config.run do |config|
  config.vm.box = "lucid32"

  # The url from where the 'config.vm.box' box will be fetched if needed
  config.vm.box_url = "http://files.vagrantup.com/lucid32.box"

  config.vm.network "192.168.42.42"
  
  config.vm.forward_port "shopify-http", 80, 8080
  config.vm.forward_port "shopify-https", 443, 8443

  config.vm.share_folder("shopify-dev", "/shopify-dev", "shopify_php_api")

  # check source directories exist.
  ["shopify_php_api"].each do |path|
    if (!(File.exists?(path) && File.directory?(path)))
      puts("DD:directory #{path} not found cannot mount it")
    end
  end
  
  # if this directory (or link) this it will cache all update packages.
  path="varcacheapt"
  if File.exists?(path) && File.directory?(path)
    puts("DD:apt-cache found directory #{path} mounting as /var/cache/apt")
    config.vm.share_folder "v-aptcache", "/var/cache/apt", path
  else 
    puts("DD:apt-cache directory #{path} not found cannot mount as /var/cache/apt")
  end

  # Enable and configure the chef solo provisioner
  config.vm.provision :chef_solo do |chef|
      # We're going to download our cookbooks from the web
      #chef.recipe_url = "http://files.vagrantup.com/getting_started/cookbooks.tar.gz"
      chef.cookbooks_path =  ["cookbooks", "opscodecookbooks"]

      # Tell chef what recipe to run. In this case, the `vagrant_main` recipe
      # does all the magic.
      chef.add_recipe("vagrant_main")
      #   chef.add_recipe "mysql"
      #   chef.add_role "web"
      #   # You may also specify custom JSON attributes:
      #   chef.json = { :mysql_password => "foo" }
    end

end
