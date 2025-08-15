local load = function(mod)
  package.loaded[mod] = nil
  require(mod)
end

load('config.settings')
-- load('config.commands')
load('config.keymaps')

require("config.lazy")
