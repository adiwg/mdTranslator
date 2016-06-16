require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module TimePeriod
          def self.build(intObj)
            Jbuilder.new do |json|
              json.id intObj[:timeId]
              json.description intObj[:description]
              json.beginPosition intObj[:beginTime][:dateTime] unless intObj[:beginTime].nil?
              json.endPosition intObj[:endTime][:dateTime] unless intObj[:endTime].nil?
            end
          end
        end
      end
    end
  end
end
