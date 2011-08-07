# Vagrant for shopify app

NOTE: To install vagrant on Mac OSX, you need to have rubydev installed.  To install rubydev, just install Xcode.


Use this to get a working shopify (php for now) setup.

*   access the shopify app at localhost:8080
*   _if you map shopify.dev.imetrical.com to 192.168.43.42, (/etc/hosts)_
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

## Pierre-Luc was here

    After you checkout, you should run this line if you want this to work
    rm -rf opscodecookbooks/zenoss/
    
    Probably, updating submodule references will fix it.   
    