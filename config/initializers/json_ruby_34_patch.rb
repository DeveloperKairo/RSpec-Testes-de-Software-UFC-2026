module ActiveSupport
  module JSON
      def self.decode(json, options = {})
        data = ::JSON.parse(json, **options)
        if ActiveSupport.parse_json_times
          convert_dates_from(data)
        else
          data
        end
      rescue ::JSON::ParserError => e
        raise parse_error(e.message)
      end
  end
end
