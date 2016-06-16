require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module CoverageItem
          def self.build(intObj)
            Jbuilder.new do |json|
              json.itemName intObj[:itemName]
              json.itemType intObj[:itemType]
              json.itemDescription intObj[:itemDescription]
              json.minValue intObj[:minValue]
              json.maxValue intObj[:maxValue]
              json.units intObj[:units]
              json.scaleFactor intObj[:scaleFactor]
              json.offset intObj[:offset]
              json.meanValue intObj[:meanValue]
              json.standardDeviation intObj[:standardDeviation]
              json.bitsPerValue intObj[:bitsPerValue]
              json.classifiedData do
                cd = intObj[:classedData]
                json.numberOfClasses cd[:numberOfClasses]
                json.classifiedDataItem(cd[:classedDataItems]) do |cdi|
                  json.className cdi[:className]
                  json.classDescription cdi[:classDescription]
                  json.classValue cdi[:classValue]
                end
              end unless intObj[:classedData].empty?
              json.sensorInfo do
                si = intObj[:sensorInfo]
                json.toneGradations si[:toneGradations]
                json.sensorMin si[:sensorMin]
                json.sensorMax si[:sensorMax]
                json.sensorUnits si[:sensorUnits]
                json.sensorPeakResponse si[:sensorPeakResponse]
              end unless intObj[:sensorInfo].empty?
            end
          end
        end
      end
    end
  end
end
