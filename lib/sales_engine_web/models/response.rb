module SalesEngineWeb
  class Response
    attr_reader :body, :status

    DEFAULT_BODY = {}.to_json

    def initialize(args = {})
      @body = args[:body] || DEFAULT_BODY
      @status = args[:status]
    end
  end
end