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

  #fix default_render_method bug: Hirb Error: undefined method `count' for true:TrueClass
  Hirb::View.instance_eval do
    self.render_method = lambda do |output| 
      return unless output.is_a? String
      page_output(output) || puts(output)
    end
  end

  class Hirb::Helpers::Mysql2Result
    def self.render(output, options={})
      rows = output.to_a
      fields = output.fields
      rows = rows.map do |r|
        Hash[fields.zip(r)]
      end
      output = rows
      options = {}.merge(:class=>"Hirb::Helpers::AutoTable")

      Hirb::View.load_config unless Hirb::View.config_loaded?
      Hirb::View.render_output(output, options.merge(:console=>true, fields: fields))
    end
  end

  Hirb.add_view Mysql2::Result, :class=>Hirb::Helpers::Mysql2Result
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
