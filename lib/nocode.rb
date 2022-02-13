# frozen_string_literal: true

require 'benchmark'
require 'csv'
require 'fileutils'
require 'json'
require 'singleton'
require 'time'
require 'yaml'

# Util
require 'nocode/util'

# Core
require 'nocode/executor'

module Nocode
  class << self
    def execute(yaml, io: $stdout)
      Executor.new(yaml, io: io).execute
    end
  end
end
