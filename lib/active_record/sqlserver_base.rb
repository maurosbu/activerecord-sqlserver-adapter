module ActiveRecord
  module ConnectionHandling
    def sqlserver_connection(config) #:nodoc:
      config = config.symbolize_keys
      config.reverse_merge! mode: :dblib
      mode = config[:mode].to_s.downcase.underscore.to_sym
      case mode
      when :dblib
        require 'tiny_tds'
      else
        raise ArgumentError, "Unknown connection mode in #{config.inspect}."
      end
      ConnectionAdapters::SQLServerAdapter.new(nil, nil, config.merge(mode: mode))
    end
  end
end
