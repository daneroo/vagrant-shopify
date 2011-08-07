# Vagrant for shopify app

NOTE: To install vagrant on Mac OSX, you need to have rubydev installed.  To install rubydev, just install Xcode.


Use this to get a working shopify (php for now) setup.

*   access the shopify app at localhost:8080
*   _if you map shopify.dev.imetrical.com to 192.168.42.42, (/etc/hosts)_
    *   access the shopify app at http://shopify.dev.imetrical.com:80
    *   access the shopify app at https://shopify.dev.imetrical.com:443
    
## Conguring
Vagrant mounts to directories into the vm, one for each app.
Instead of providng path to the directly in the Vagrant file, the vagrant file points to a local directory which is assumed to be a link to you local source. So you can do something like:

    ln -s .../shopify_php_api .

It is possible to speed up the deployment of the machine by caching, `/var/cache/apt`.
That way packages are cached from on invocation to the other. 
if a diretcory: `varcacheapt` exists in the current directory, it will be mounted.
I actually use a symbolink link to a directory which gets used for many projects:

    mkdir varcacheapt
    # or
    ln -s ../varcacheapt/ varcacheapt
    
    dirac:vagrant-shopify(master) daniel$ ls -ld varcacheapt
    lrwxr-xr-x  1 daniel  staff  15 31 May 11:07 varcacheapt -> ../varcacheapt/


## Checking out the source
Don't forget to fetch the submodules

    git clone git@github.com:daneroo/vagrant-shopify.git
    git submodule update --init --recursive 

## Managing the the opscoode cookbooks
This is how we added the cookbooks originally

    git submodule add git://github.com/opscode/cookbooks.git opscodecookbooks
    git commit -am "Import Opscode cookbooks"

This is how we update them

    ...
## Chef gem version
To bring chef to 0.10.x,

    sudo gem update chef

Need to play with Virtualbox 4.1.x, vagrant 0.8, and get a new basbox.
For now, firewall recipe is brpken for me so:...

    rm -rf opscodecookbooks/firewall
    
## Nice favicon sets

    http://www.freefavicon.com/freefavicons/objects/alpha.php?alpha=p    