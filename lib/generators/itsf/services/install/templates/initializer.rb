Itsf::Services.configure do |config|
  # Set verbosity level by environment and level.
  # 
  # Listed verbosity levels will be silenced and don't generate output.
  # 
  # Default: 
  # 
  # config.silenced_levels = {
  #   test:        [],
  #   development: [],
  #   production:  []
  # }
  # 
  config.silenced_levels = {
    test:        [],
    development: [],
    production:  []
  }
end