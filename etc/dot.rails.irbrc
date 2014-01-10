##rails console settings invoked from ~/.irbrc

##routes
#Usage: greproutes "news" 
#  nil is for all routes
def greproutes(match = nil)
  Rails.application.reload_routes!
  all_routes = Rails.application.routes.routes
 
  require 'rails/application/route_inspector'
  inspector = Rails::Application::RouteInspector.new
 
  routes = inspector.format(all_routes, ENV['CONTROLLER'])
 
  ansi_bold       = "\033[1m"
  ansi_reset      = "\033[0m"
 
  if (match)
    match = match.to_s
    puts routes.grep(/#{match}/).map { |r|
      r.gsub!(match, "#{ansi_bold}#{match}#{ansi_reset}")
    }.join("\n")
  else
    puts routes.join "\n"
  end
end

##############################################
#         DB

def sql(query)
  ActiveRecord::Base.connection.select_all(query)
end 

#let AR log to default stdout, not use when developing, it's default
#ActiveRecord::Base.logger = logger

#toggle on and off
def toggle_sql
  if ActiveRecord::Base.logger
    set_logger nil and return false
  else
    set_logger Logger.new(STDOUT) and return true
  end
end
def set_logger(logger)
  ActiveRecord::Base.logger = logger
  ActiveRecord::Base.clear_active_connections!
end
#set_logger nil # start with the normal logger


##############################################
#       Rails models

#将model类加载到当前进程，在启动rails c后，默认的model类常量还没加载到当前进程，第一次调用时会加载
#这里一次加载进来，以便后面的类反省操作
#
def require_models
  Dir.glob("app/models/**/*.rb").each{|f| require File.basename(f)}
end

def models
  require_models
  ActiveRecord::Base.subclasses #depend on ush settings
end

def model_names
  models.map &:name 
end
