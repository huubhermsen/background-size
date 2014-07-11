"use strict"

###
Set paths
###
src_folder = 'source'
dest_folder = 'build'
src_files = src_folder + '/**/'

###
Grunt setup
###
module.exports = (grunt) ->

	require('load-grunt-tasks')(grunt);

	grunt.initConfig {
		pkg: grunt.file.readJSON 'package.json'
		watch: {
			options: {
				livereload: 8000
				spawn: false
			}
			sass: {
				files: [ src_files + '*.scss' ]
				tasks: [ 'compass' ]
			}
			coffee: {
				files: [ src_files + '*.coffee' ]
				tasks: [ 'coffee' ]
			}
			jade: {
				files: [ src_files + '*.jade' ]
				tasks: [ 'jade' ]
			}
			javascript: {
				files: [ src_files + '*.js' ]
				tasks: [ 'copy:javascript' ]
			}
			images: {
				files: [ src_files + '*.{png,jpg,gif,svg}' ]
				tasks: [ 'copy:images' ]
			}
			fonts: {
				files: [ src_files + '*.{woff,svg,ttf,otf,eot}' ]
				tasks: [ 'copy:fonts' ]
			}		
		}
		connect: {
			target: {
				options: {
					port: 9000
					base: dest_folder
				}
			}
		}
		coffee: {
			build: {
				expand: true
				cwd: src_folder + '/coffeescript'
				src: [ '*.coffee' ]
				dest: dest_folder + '/asset/js'
				ext: '.js'
	    	}
		}
		compass: {
			dist: {
				options: {
					sassDir: src_folder + '/sass'
					cssDir: dest_folder + '/asset/css'
				}
			}
		}
		jade: {
			compile: {
				options: {
					data: {
						debug: true
						enviroment: 'production'
					}
					pretty: true
				}
				files: [{
      				expand: true
      				cwd: src_folder + '/templates'
      				src: [ '*.jade', '!/includes/*.jade' ]
      				dest: dest_folder
      				ext: '.html'
    			}]
			}
		}
		clean: [ dest_folder ]
		copy: {
			javascript: {
				files: [{
					expand: true,
					cwd: src_folder + '/javascript',
					src: [ '**' ],
					dest: dest_folder + '/asset/js'
				}]
			}
			images: {
				files: [{
					expand: true,
					cwd: src_folder + '/images',
					src: [ '**' ],
					dest: dest_folder + '/asset/image'
				}]
			}
			fonts: {
				files: [{
					expand: true,
					cwd: src_folder + '/font',
					src: [ '**' ],
					dest: dest_folder + '/asset/font'
				}]
			}
		}
		imagemin: {
			static: {
				files: [{
					expand: true
					src: [ dest_folder + '/asset/image/*.{png,jpg,gif}' ]
				}]
			}
		}
	}

	grunt.registerTask 'build', [ 'clean', 'copy:javascript', 'copy:images', 'copy:fonts', 'coffee', 'jade', 'compass' ]
	grunt.registerTask 'default', [ 'build', 'connect', 'watch' ]
	grunt.registerTask 'optimize', [ 'imagemin' ]