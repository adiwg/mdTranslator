require 'jbuilder'
require_relative 'mdJson_base'
require_relative 'mdJson_resourceIdentifier'
require_relative 'mdJson_coverageItem'
require_relative 'mdJson_imageInfo'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson
        module CoverageInfo
          extend MdJson::Base

          def self.build(intObj)
            unless intObj.empty?
              Jbuilder.new do |json|
                json.coverageType intObj[:coverageType]
                json.coverageName intObj[:coverageName]
                json.coverageDescription intObj[:coverageDescription]
                json.processingLevel ResourceIdentifier.build(intObj[:processingLevel]) unless intObj[:processingLevel].empty?
                json.coverageItem json_map(intObj[:coverageItems], CoverageItem)
                json.imageInfo ImageInfo.build(intObj[:imageInfo]) unless intObj[:imageInfo].empty?
              end
            end
          end
        end
      end
    end
  end
end
