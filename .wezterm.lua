local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local appearance = require 'appearance'
local shell = require 'shell'
local tab_bar = require 'tab_bar'
local remap = require 'remap'

appearance(config)
shell(config)
tab_bar(config)
remap(config)

return config
