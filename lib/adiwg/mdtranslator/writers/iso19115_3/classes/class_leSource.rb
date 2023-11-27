# ISO <<Class>> LE_Source
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-09-27 original script.

require_relative 'class_resolution'
require_relative 'class_referenceSystem'
require_relative 'class_citation'
require_relative 'class_scope'
require_relative 'class_processStep'
require_relative 'class_identifier'
require_relative 'class_nominalResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class LE_Source

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSource, inContext = nil)

                  # classes used
                  resolutionClass = MD_Resolution.new(@xml, @hResponseObj)
                  referenceClass = MD_ReferenceSystem.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)
                  stepClass = ProcessStep.new(@xml, @hResponseObj)
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                  nominalClass = LE_NominalResolution.new(@xml, @hResponseObj)

                  outContext = 'source'
                  outContext = outContext + ' ' + hSource[:sourceId].to_s unless hSource[:sourceId].nil?
                  outContext = inContext + ' source' unless inContext.nil?

                  # source - id (tag attribute id="")
                  attributes = {}
                  s = hSource[:sourceId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  @xml.tag!('mrl:LE_Source', attributes) do

                     # source - description
                     unless hSource[:description].nil?
                        @xml.tag!('mrl:description') do
                           @xml.tag!('gco:CharacterString', hSource[:description])
                        end
                     end
                     if hSource[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:description')
                     end

                     # source - spatial resolution {MD_Resolution}
                     unless hSource[:spatialResolution].empty?
                        @xml.tag!('mrl:sourceSpatialResolution') do
                           resolutionClass.writeXML(hSource[:spatialResolution], outContext)
                        end
                     end
                     if hSource[:spatialResolution].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceSpatialResolution')
                     end

                     # source - reference system {MD_ReferenceSystem}
                     unless hSource[:referenceSystem].empty?
                        @xml.tag!('mrl:sourceReferenceSystem') do
                           referenceClass.writeXML(hSource[:referenceSystem])
                        end
                     end
                     if hSource[:referenceSystem].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceReferenceSystem')
                     end

                     # source - citation {CI_Citation}
                     unless hSource[:sourceCitation].empty?
                        @xml.tag!('mrl:sourceCitation') do
                           citationClass.writeXML(hSource[:sourceCitation], outContext)
                        end
                     end
                     if hSource[:sourceCitation].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceCitation')
                     end

                     # source - metadata [] {CI_Citation}
                     aCitations = hSource[:metadataCitations]
                     aCitations.each do |hCitation|
                        @xml.tag!('mrl:sourceMetadata') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aCitations.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceMetadata')
                     end

                     # source - scope {MD_Scope}
                     unless hSource[:scope].empty?
                        @xml.tag!('mrl:scope') do
                           scopeClass.writeXML(hSource[:scope], outContext)
                        end
                     end
                     if hSource[:scope].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:scope')
                     end

                     # source - process step [] {ProcessStep}
                     aSteps = hSource[:sourceSteps]
                     aSteps.each do |hStep|
                        @xml.tag!('mrl:sourceStep') do
                           stepClass.writeXML(hStep)
                        end
                     end
                     if aSteps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceStep')
                     end

                     # source - processed level {MD_Identifier}
                     unless hSource[:processedLevel].empty?
                        @xml.tag!('mrl:processedLevel') do
                           identifierClass.writeXML(hSource[:processedLevel], outContext)
                        end
                     end
                     if hSource[:processedLevel].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:processedLevel')
                     end

                     # source - resolution {LE_NominalResolution}
                     unless hSource[:resolution].empty?
                        @xml.tag!('mrl:resolution') do
                           nominalClass.writeXML(hSource[:resolution], outContext)
                        end
                     end
                     if hSource[:resolution].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:resolution')
                     end

                  end # mrl:LI_Source tag
               end # writeXML
            end # LI_Source class

         end
      end
   end
end
