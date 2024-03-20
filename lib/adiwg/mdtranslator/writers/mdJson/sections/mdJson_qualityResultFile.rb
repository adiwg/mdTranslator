require 'jbuilder'
require_relative 'mdJson_format'

module ADIWG
  module Mdtranslator
    module Writers
      module MdJson

        module QualityResultFile
          def self.build(hQualityResultFile)
            Jbuilder.new do |json|
                json.fileName hQualityResultFile[:fileName]
                json.fileDescription hQualityResultFile[:fileDescription]
                json.fileType hQualityResultFile[:fileType]
                json.fileFormat Format.build(hQualityResultFile[:fileFormat]) unless hQualityResultFile[:fileFormat].nil?
            end
          end
        end

      end
    end
  end
end