# WP-Site
A simple test set up for automating a Node.js, Composer,  and Bower Wordpress Site build in timber and utilizing the timber starter theme.

*** While this is somewhat functional right now, it's VERY MUCH a work in progress and not finished ***

This process assumes you already have the WordPress database installed and will update the wp-config.php with user input.
If this isn't the case, you will still have to go through the WordPress install manually.

Required packages
- Node & npm (Package manager and build system)
- Composer (Wordpress support, grabs wordpress and plugins)
- Bower (Front end package manager)


Usage: Run `npm run setup`
This runs npm install, Composer install, and bower install
After this, a bash script runs that modifies the wp-config file for you. Input the database name, username, and password.


Build System: npm
Compile SASS, JS (ES6 - Babel)
Watch For Changes


This is a project I am working on in the background of my day to day work to get more comfortable with npm as a build system, and thus will reflect my growing understanding. If you have any input or want to contribute, please feel free as I could learn a lot from working with others!
