# ISO <<Class>> LI_Source
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-10 original script.

require_relative 'class_resolution'
require_relative 'class_referenceSystem'
require_relative 'class_citation'
require_relative 'class_scope'
require_relative 'class_processStep'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class LI_Source

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
                  stepClass = LI_ProcessStep.new(@xml, @hResponseObj)

                  outContext = 'source'
                  outContext = inContext + ' source' unless inContext.nil?

                  # source - id (tag attribute id="")
                  attributes = {}
                  s = hSource[:sourceId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  @xml.tag!('mrl:LI_Source', attributes) do

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

                     # source - process step [] {LI_ProcessStep}
                     aSteps = hSource[:sourceSteps]
                     aSteps.each do |hStep|
                        @xml.tag!('mrl:sourceStep') do
                           stepClass.writeXML(hStep)
                        end
                     end
                     if aSteps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:sourceStep')
                     end

                  end # mrl:LI_Source tag
               end # writeXML
            end # LI_Source class

         end
      end
   end
end
