# ISO <<Class>> LI_ProcessStep
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-10 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_responsibility'
require_relative 'class_source'
require_relative 'class_timePeriod'
require_relative 'class_citation'
require_relative 'class_scope'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class LI_ProcessStep

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hStep, inContext = nil)

                  # classes used
                  responsibilityClass = CI_Responsibility.new(@xml, @hResponseObj)
                  sourceClass = Source.new(@xml, @hResponseObj)
                  periodClass = TimePeriod.new(@xml, @hResponseObj)
                  citationClass = CI_Citation.new(@xml, @hResponseObj)
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)

                  outContext = 'process step'
                  outContext = inContext + ' process step' unless inContext.nil?
                  outContext = outContext + ' ' + hStep[:stepId].to_s unless hStep[:stepId].nil?

                  # process step - id
                  attributes = {}
                  s = hStep[:stepId]
                  unless s.nil?
                     attributes = { id: s.gsub(/[^0-9A-Za-z]/,'') }
                  end

                  @xml.tag!('mrl:LI_ProcessStep', attributes) do

                     # process step - description (required)
                     unless hStep[:description].nil?
                        @xml.tag!('mrl:description') do
                           @xml.tag!('gco:CharacterString', hStep[:description])
                        end
                     end
                     if hStep[:description].nil?
                        @NameSpace.issueWarning(260, 'mrl:description')
                     end

                     # process step - rationale
                     unless hStep[:rationale].nil?
                        @xml.tag!('mrl:rationale') do
                           @xml.tag!('gco:CharacterString', hStep[:rationale])
                        end
                     end
                     if hStep[:rationale].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:rationale')
                     end

                     # process step - step datetime {TimePeriod}
                     # {TimeInstant} - not implemented
                     unless hStep[:timePeriod].empty?
                        @xml.tag!('mrl:stepDateTime') do
                           periodClass.writeXML(hStep[:timePeriod])
                        end
                     end
                     if hStep[:timePeriod].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:stepDateTime')
                     end

                     # process step - processor [] {CI_Responsibility}
                     aProcessors = hStep[:processors]
                     aProcessors.each do |hProcessor|
                        @xml.tag!('mrl:processor') do
                           responsibilityClass.writeXML(hProcessor, outContext)
                        end
                     end
                     if aProcessors.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:processor')
                     end

                     # process step - reference [] {CI_Citation}
                     aReferences = hStep[:references]
                     aReferences.each do |hCitation|
                        @xml.tag!('mrl:reference') do
                           citationClass.writeXML(hCitation, outContext)
                        end
                     end
                     if aReferences.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:reference')
                     end

                     # process step - scope {MD_Scope}
                     unless hStep[:scope].empty?
                        @xml.tag!('mrl:scope') do
                           scopeClass.writeXML(hStep[:scope], outContext)
                        end
                     end
                     if hStep[:scope].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:scope')
                     end

                     # process step - source [] {Source}
                     aSources = hStep[:stepSources]
                     aSources.each do |hSource|
                        @xml.tag!('mrl:source') do
                           sourceClass.writeXML(hSource)
                        end
                     end
                     if aSources.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mrl:source')
                     end

                  end # mrl:LI_ProcessStep tag
               end # writeXML
            end # LI_ProcessStep class

         end
      end
   end
end
