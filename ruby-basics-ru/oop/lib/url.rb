# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  include Comparable
  attr_accessor :uri

  extend Forwardable
  def_delegators :@uri, :scheme, :host, :port, :origin, :path

  def initialize(url)
    @uri = URI url
    @params = query_params
  end

  def query_params
    query_string = @uri.query
    return {} unless query_string

    query_string.split('&').each_with_object({}) do |pair, acc|
      key, value = pair.split('=')
      acc[key.to_sym] = value
    end
  end

  def query_param(key, default = nil)
    query = query_params
    query[key] || default
  end

  def to_s
    params = query_params.sort.map { |pair| pair.join('=') }.join('&')
    "#{origin}#{path}?#{params}"
  end

  def <=>(other)
    url1 = to_s
    url2 = other.to_s

    return 0 if url1 == url2

    url1 > url2 ? 1 : -1
  end
end
# END
