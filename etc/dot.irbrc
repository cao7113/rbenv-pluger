##put this in ~/.irbrc, autoload by irb
require 'irb/completion'
if IRB.respond_to?(:conf)
  IRB.conf[:AUTO_IDENT] = true 
end

##gems: irbtools
#require 'map_by_method' 
#require 'what_methods' 
#require 'pp' #prety print
#require 'fileutils'
#include FileUtils

if $0 == 'script/rails' && defined?(Rails) && Rails.env #in rails
  railsrc = File.expand_path('~/.rails.irbrc')
  load railsrc if File.exists?(railsrc) 
end

##from my ruby config
#require 'ulog'
#require 'console_util'
#require 'meta'
#require 'tracing'
