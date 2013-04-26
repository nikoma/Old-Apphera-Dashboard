require 'yaml'
# TODO :exclude /config/ from git and use for ALL settings! Better would be settings from DB

module Settings
  aws = YAML::load( File.open(File.dirname(__FILE__) + '/../config/aws.yml' ) )
  API = aws["api"]
  SECRET = aws["secret"]
  bunny = YAML::load( File.open(File.dirname(__FILE__) + '/../config/bunny.yml' ) )
  HOST = bunny["host"]
  USER = bunny["user"]
  PASS = bunny["pass"]
end
