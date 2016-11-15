##put this in ~/.irbrc, autoload by irb
require 'irb/completion'
if IRB.respond_to?(:conf)
  IRB.conf[:AUTO_IDENT] = true 
end
require 'byebug'

# $0: script/rails
if $0 == 'bin/rails' && defined?(Rails) #in rails
  railsrc = File.expand_path('~/.rails.irbrc')
  load railsrc if File.exists?(railsrc) 
end

##from my ruby config
#require 'ulog'
#require 'meta'
#require 'tracing'
require 'console_util'
