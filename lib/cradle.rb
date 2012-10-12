require 'json'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/basic_repository', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/basic_repository/entities', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/basic_repository/interactors', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/boundaries', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/entities', __FILE__)
$LOAD_PATH << File.expand_path('../../lib/interactors', __FILE__)

module Cradle

  class CradleError < StandardError; end

end
