# WP-Site
A simple test set up for automating a Node.js, Composer,  and Bower Wordpress Site build in timber and utilizing the timber starter theme.

*** While this is somewhat functional right now, it is VERY MUCH a work in progress and not finished ***

This process assumes you already have the wordpress database installed and just updates the wp-config.php with user input.
If this isn't the case, you will still have to go through the wordpress install manually.

Required packages
- Node & npm (Package manager and build system)
- Composer (Wordpress support, grabs wordpress and plugins)
- Bower (Front end package manager)


Usage: Just run `npm run setup`
This runs npm install, Composer install, and bower install
After this, a bash script runs that modifies the wp-config file for you. Just input the database name, username, and password.


Build System: npm
"setup": "npm install && composer install",
"wordpresssetup": "./scripts/wordpress.sh",
"lint": "jshint **.js",
"build:sass": "node-sass -r --output-style compressed src/style.scss -o dist",
"build:js": "babel-core -r --output-style compressed src/scripts.js -o dist && browserify src/js/main.js -o dist",
"build:all": "npm run build:sass && npm run build:js",
"watch:css": "onchange 'src/scss/*.scss' -- npm run build:css",
"watch:js": "onchange 'src/js/*.js' -- npm run build:js",
"watch:all": "parallelshell 'npm run watch:css' 'npm run watch:js'"
