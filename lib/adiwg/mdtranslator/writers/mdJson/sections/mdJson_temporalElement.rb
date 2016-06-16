require 'jbuilder'

require_relative 'mdJson_base'
require_relative 'mdJson_timePeriod'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module TemporalElement
          extend MdJson::Base

          def self.build(intObj)
            remap = {
              date: [],
              timeInstant: [],
              timePeriod: []
            }

            intObj.each do |obj|
              obj.each { |key, value| remap[key] << value unless value.empty? }
            end

            Jbuilder.new do |json|
              json.timeInstant(remap[:timeInstant]) do |ti|
                json.id ti[:timeId]
                json.description ti[:description]
                json.timePosition ti[:timePosition][:dateTime] unless ti[:timePosition].nil?
              end unless remap[:timeInstant].empty?
              json.timePeriod json_map(remap[:timePeriod], TimePeriod)
              json.date(remap[:date]) { |dt| json.merge! dt[:dateTime] } unless remap[:date].empty?
            end unless remap[:date].empty? && remap[:timeInstant].empty? && remap[:timePeriod].empty?
          end
        end
      end
    end
  end
end
