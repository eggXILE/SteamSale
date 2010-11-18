require 'game_list'
require 'parser'
require 'result_output'
include ResultOutput


gl = GameList.new()
parser = Parser.new(g)
parser.execute
ResultOutput.sale(parser.result)
