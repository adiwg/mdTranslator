# ISO <<Class>> MD_ReferenceSystem
# writer
# 19115-1 output for XML

# History:
# 	Stan Smith 2019-03-19 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'class_codelist'
require_relative 'class_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_ReferenceSystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hSystem, inContext = nil)

                  # classes used
                  intMetadataClass = InternalMetadata.new
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  idClass = MD_Identifier.new(@xml, @hResponseObj)

                  outContext = 'spatial reference system'
                  outContext = inContext + ' spatial reference system' unless inContext.nil?

                  unless hSystem.empty?
                     @xml.tag!('mrs:MD_ReferenceSystem') do
                        haveSystem = false

                        # reference system - reference system identifier {MD_Identifier}
                        unless hSystem[:systemIdentifier].empty?
                           @xml.tag!('mrs:referenceSystemIdentifier') do
                              idClass.writeXML(hSystem[:systemIdentifier], outContext)
                           end
                           haveSystem = true
                        end

                        # reference system - reference system WKT {MD_Identifier}
                        if hSystem[:systemIdentifier].empty? && !hSystem[:systemWKT].nil?
                           hIdentifier = intMetadataClass.newIdentifier
                           hIdentifier[:identifier] = 'WKT'
                           hIdentifier[:namespace] = 'www.opengeospatial.org/standards/wkt-crs'
                           hIdentifier[:description] = hSystem[:systemWKT]
                           @xml.tag!('mrs:referenceSystemIdentifier') do
                              idClass.writeXML(hIdentifier, outContext)
                           end
                           haveSystem = true
                        end

                        # test for missing reference system identifier / reference system WKT
                        # both use the same ISO tag
                        if hSystem[:systemIdentifier].empty? && @hResponseObj[:writerShowTags] && !haveSystem
                           @xml.tag!('mrs:referenceSystemIdentifier')
                        end

                        # reference system - reference system type {MD_ReferenceSystemTypeCode}
                        unless hSystem[:systemType].nil?
                           @xml.tag!('mrs:referenceSystemType') do
                              codelistClass.writeXML('mrs', 'iso_referenceSystemType', hSystem[:systemType])
                           end
                           haveSystem = true
                        end
                        if hSystem[:systemType].empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mrs:referenceSystemType')
                        end

                        if !haveSystem
                           @NameSpace.issueWarning(380, 'mrs:referenceSystemIdentifier', inContext)
                           @NameSpace.issueWarning(381, 'mrs:referenceSystemType', inContext)
                        end

                        # reference system parameter sets not implemented in ISO 19115-3

                     end
                  end

               end # writeXML
            end # MD_ReferenceSystem class

         end
      end
   end
end
