##put this in ~/.irbrc, autoload by irb
require 'irb/completion'
if IRB.respond_to?(:conf)
  IRB.conf[:AUTO_IDENT] = true 
end

# hirb
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end
if defined? Hirb
  Hirb.enable
end

if $0 == 'script/rails' && defined?(Rails) && Rails.env #in rails
  railsrc = File.expand_path('~/.rails.irbrc')
  load railsrc if File.exists?(railsrc) 
end

##from my ruby config
#require 'ulog'
#require 'meta'
#require 'tracing'
require 'console_util'
