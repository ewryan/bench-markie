#!/usr/bin/env ruby

require 'slop'
require 'yaml'
require 'celluloid'
Dir[File.dirname(__FILE__) + '/lib/benches/*.rb'].each {|file| require file }

opts = Slop.parse do
  banner "Usage: #{$1} [options]"
  on 'bench=', 'Benchmark config file'
end

target_file_path = "#{File.dirname(__FILE__)}/config/#{opts[:bench]}.yml"

unless File.exists? target_file_path
  puts "Unable to locate file '#{target_file_path}'"
  exit 1
end

bench = YAML.load(File.open(target_file_path))
bench["benches"].each do |bench_class, options|
  klass = Kernel.const_get bench_class

  1.upto(options["instances"]).each do |i|
    instance = klass.new options["args"]
    instance.async.run
  end
end
