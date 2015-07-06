puts "==loading .pryrc"

#Pry.config.editor = "vim"
#Pry.commands.alias_command 'c', 'continue'
#Pry.commands.alias_command 's', 'step'
#Pry.commands.alias_command 'n', 'next'
#Pry.commands.alias_command 'f', 'finish'

require 'console_util'

# ref https://github.com/pry/pry/wiki/FAQ#hirb
begin
  require 'hirb'
rescue LoadError
  # Missing goodies, bummer
end

if defined? Hirb
  #fix default_render_method bug: Hirb Error: undefined method `count' for true:TrueClass
  Hirb::View.instance_eval do
    self.render_method = lambda do |output| 
      return unless output.is_a? String
      page_output(output) || puts(output)
    end
  end

  # Slightly dirty hack to fully support in-session Hirb.disable/enable toggling
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable

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
      Hirb::View.render_output(output, options.merge(console: true, fields: fields))
    end
  end

  Hirb.add_view Mysql2::Result, :class=>Hirb::Helpers::Mysql2Result
end
