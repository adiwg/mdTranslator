# mdJson 2.0 writer - coverage description

# History:
#   Stan Smith 2017-03-16 refactored for mdJson/mdTranslator 2.0
#   Josh Bradley original script

require 'jbuilder'
require_relative 'mdJson_identifier'
require_relative 'mdJson_attributeGroup'
require_relative 'mdJson_imageDescription'

module ADIWG
   module Mdtranslator
      module Writers
         module MdJson

            module CoverageDescription

               def self.build(hCoverage)

                  @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                  Jbuilder.new do |json|
                     json.coverageName hCoverage[:coverageName]
                     json.coverageDescription hCoverage[:coverageDescription]
                     json.processingLevelCode Identifier.build(hCoverage[:processingLevelCode]) unless hCoverage[:processingLevelCode].empty?
                     json.attributeGroup @Namespace.json_map(hCoverage[:attributeGroups], AttributeGroup)
                     json.imageDescription ImageDescription.build(hCoverage[:imageDescription]) unless hCoverage[:imageDescription].empty?
                  end

               end # build
            end # CoverageDescription

         end
      end
   end
end
