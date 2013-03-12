current_path = File.expand_path('lib')
$LOAD_PATH.push(current_path) unless $LOAD_PATH.include?($LOAD_PATH)
Bundler.require
require 'sales_engine_web'

run SalesEngineWeb::Server