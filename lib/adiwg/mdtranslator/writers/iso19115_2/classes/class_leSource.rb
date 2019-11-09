# ISO <<Class>> LE_Source
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-09-25 original script.

require_relative 'class_fraction'
require_relative 'class_referenceSystem'
require_relative 'class_citation'
require_relative 'class_processStep'
require_relative 'class_rsIdentifier'
require_relative 'class_nominalResolution'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class LE_Source

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hSource, inContext = nil)

                  # classes used
                  fractionClass = MD_RepresentativeFraction.new(@xml, @hResponseObj)
                  systemClass = MD_ReferenceSystem.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  stepClass = ProcessStep.new(@xml, @hResponseObj)
                  identifierClass = RS_Identifier.new(@xml, @hResponseObj)
                  resolutionClass = LE_NominalResolution.new(@xml, @hResponseObj)

                  # source - id
                  attributes = {}
                  s = hSource[:sourceId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  outContext = 'source'
                  outContext = outContext + ' ' + hSource[:sourceId].to_s unless hSource[:sourceId].nil?
                  outContext = inContext + ' ' + outContext unless inContext.nil?

                  @xml.tag!('gmi:LE_Source', attributes) do

                     # source - description
                     unless hSource[:description].nil?
                        @xml.tag!('gmd:description') do
                           @xml.tag!('gco:CharacterString', hSource[:description])
                        end
                     end
                     if hSource[:description].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:description')
                     end

                     # source - scale denominator {MD_RepresentativeFraction}
                     hResolution = hSource[:spatialResolution]
                     unless hResolution[:scaleFactor].nil?
                        @xml.tag!('gmd:scaleDenominator') do
                           fractionClass.writeXML(hResolution[:scaleFactor])
                        end
                     end
                     if hResolution[:scaleFactor].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:scaleDenominator')
                     end

                     # source - reference system {MD_ReferenceSystem}
                     hSystem = hSource[:referenceSystem]
                     unless hSystem.empty?
                        @xml.tag!('gmd:sourceReferenceSystem') do
                           systemClass.writeXML(hSystem)
                        end
                     end
                     if hSystem.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:sourceReferenceSystem')
                     end

                     # source - citation {CI_Citation}
                     hCitation = hSource[:sourceCitation]
                     unless hCitation.empty?
                        @xml.tag!('gmd:sourceCitation') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if hCitation.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:sourceCitation')
                     end

                     # source - extent [] {EX_Extent} (not implemented)

                     # source - source step [] {ProcessStep}
                     aSteps = hSource[:sourceSteps]
                     aSteps.each do |hStep|
                        @xml.tag!('gmd:sourceStep') do
                           stepClass.writeXML(hStep)
                        end
                     end
                     if aSteps.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:sourceStep')
                     end

                     # source - processed level {RS_Identifier}
                     hProcess = hSource[:processedLevel]
                     unless hProcess.empty?
                        @xml.tag!('gmi:processedLevel') do
                           identifierClass.writeXML(hProcess, outContext)
                        end
                     end
                     if hProcess.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:processedLevel')
                     end

                     # source - resolution {LE_NominalResolution}
                     hNominal = hSource[:resolution]
                     unless hNominal.empty?
                        @xml.tag!('gmi:resolution') do
                           resolutionClass.writeXML(hNominal, outContext)
                        end
                     end
                     if hNominal.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmi:resolution')
                     end

                  end # gmd:LE_Source tag
               end # writeXML
            end # LE_Source class

         end
      end
   end
end
