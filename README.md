# phpenv cookbook

Installs [phpenv](https://github.com/phpenv/phpenv) php version manager
application and build php from source for production environments.

The cookbook provides LWRPs to easily build new php versions.

# Requirements

The cookbook was tested on ubuntu server 12.04 and may not works on other systems.

Requires Chef 10.16.4 or later.


# Usage

Add the `default`recipe to your run list:

    { "run_list": ["recipe[phpenv]"] }

# Attributes

By default phpenv will be installed into `/opt/phpenv` directory and can be used
by every user but only `root` can build a new php version and set the global php
version.

You can build different php versions  just like specifying e.g. the following
attributes:

    "phpenv": {
      "phps": [
        {
          "release": "5.3.25",
          "environment": { "LDFLAGS": "-lstdc++" }
        },
        "5.4.15"
      ],
      "global": "5.4.15"
    }

See [`attributes/default.rb`](attributes/default.rb) for more information.


# Recipes

## default

Installs the full stack.

## base

Installs dependencies for building php from the git source.

## install

Installs phpenv and meke it ready to build phps.

## phps

Builds different php versions specified by the `phps` attribute.

# LWRPs

## phpenv_script

Runs code in a proper phpenv environment.
The resource has the same attributes as the [`script`](http://docs.opscode.com/resource_script.html) resource and adds the following ones:

`phpenv_root`: path to the phpenv installation
`phpenv_version`: php version to use

## phpenv_php

Builds a php version. Attributes:

`release`: php release version e.g "5.3.25" or "5.5.0RC2"
`build`: build name e.g. "dev"
`ini`: ini file to use e.g. "production"
`environment`: hash of environment variables

    phpenv_php "5.3.25" do
      environment "LDFLAGS" => "-lstdc++"
    end

## phpenv_global

Sets the global php version. Attributes:

`phpenv_version`: php version to use as global
`environment`: hash of environment variables

    phpenv_global "5.3.25"

# Author

Author:: Gábor Egyed (<egyed.gabor@mentha.hu>)
