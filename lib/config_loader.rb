require "config_loader/version"
require 'yaml'

class ConfigLoader

  class NoConfigError < ArgumentError; end

  def initialize(filename: nil, stream: nil, stream_loader: nil)
    @filename      = locate_config_file(filename)
    @stream        = stream
    @stream_loader = stream_loader || YAML
  end


  def read
    open_stream
    if block_given?
      yield handle
    else
      @stream_loader.load_stream(handle)[0]
    end
    close_stream
  end


private

  attr_reader :handle

  def close_stream
    return unless @handle
    @handle.close
    @handle = nil
  end


  def config_dir
    File.expand_path( File.join( File.dirname(__FILE__), '..', '..', 'config' ) )
  end


  def locate_config_file(key)
     return nil if key == nil
     return key if File.absolute_path(key) == key
     File.expand_path( File.join( config_dir, key ) )
  end


  def open_stream
    !! @handle and return @handle
    if @stream
      @handle = @stream
    else
      @handle = File.open @filename if @filename
    end
    raise NoConfigError.new("Please suppply :filename or :stream to ConfigLoader") unless @handle
    @handle
  end

end
