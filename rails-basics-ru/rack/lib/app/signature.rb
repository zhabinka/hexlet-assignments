# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    # BEGIN
    response = @app.call(env)
    status, headers, body = response

    hash = Digest::SHA2.hexdigest body.join
    body_with_hash = body.push('<br>', hash)

    [status, headers, body_with_hash]
    # END
  end
end
