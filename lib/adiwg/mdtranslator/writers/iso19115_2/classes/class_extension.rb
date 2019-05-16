# ISO <<Class>> MD_MetadataExtensionInformation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2019-03-22 replaced Enumeration class with method
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-22 original script.

require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_enumerationList'
require_relative 'class_onlineResource'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_MetadataExtensionInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hExtension)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  olResClass = CI_OnlineResource.new(@xml, @hResponseObj)

                  outContext = 'extension information'
                  outContext = 'extension name ' + hExtension[:name] unless hExtension[:name].nil?

                  @xml.tag!('gmd:MD_MetadataExtensionInformation') do

                     # metadata extension - online resource {CI_OnLineResource}
                     hOLResource = hExtension[:onLineResource]
                     unless hOLResource.empty?
                        @xml.tag!('gmd:extensionOnLineResource') do
                           olResClass.writeXML(hOLResource, outContext)
                        end
                     end
                     if hOLResource.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:extensionOnLineResource')
                     end

                     # metadata extension = extended element information
                     @xml.tag!('gmd:extendedElementInformation') do
                        @xml.tag!('gmd:MD_ExtendedElementInformation') do

                           # extended element info - name (required)
                           s = hExtension[:name]
                           unless s.nil?
                              @xml.tag!('gmd:name') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(100, 'gmd:name')
                           end

                           # extended element info - short name
                           s = hExtension[:shortName]
                           unless s.nil?
                              @xml.tag!('gmd:shortName') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:shortName')
                           end

                           # extended element info - definition (required)
                           s = hExtension[:definition]
                           unless s.nil?
                              @xml.tag!('gmd:definition') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(101, 'gmd:definition', outContext)
                           end

                           # extended element info - obligation {MD_ObligationCode}
                           obligation = hExtension[:obligation]
                           unless obligation.nil?
                              if CodelistFun.validateItem('iso_obligation', obligation)
                                 @xml.tag!('gmd:obligation') do
                                    @xml.tag!('gmd:MD_ObligationCode', obligation)
                                 end
                              else
                                 @NameSpace.issueWarning(380, 'gmd:obligation', "#{obligation}")
                              end
                           end
                           if obligation.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:obligation')
                           end

                           # extended element info - data type (required)
                           s = hExtension[:dataType]
                           unless s.nil?
                              @xml.tag!('gmd:dataType') do
                                 codelistClass.writeXML('gmd', 'iso_entityClass', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(102, 'gmd:dataType', outContext)
                           end

                           # extended element info - maximum occurrence
                           s = hExtension[:maxOccurrence]
                           unless s.nil?
                              @xml.tag!('gmd:maximumOccurrence') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:maximumOccurrence')
                           end

                           # extended element info - parent entity [] (required)
                           aParents = hExtension[:parentEntities]
                           aParents.each do |parent|
                              @xml.tag!('gmd:parentEntity') do
                                 @xml.tag!('gco:CharacterString', parent)
                              end
                           end
                           if aParents.empty?
                              @NameSpace.issueWarning(103, 'gmd:parentEntity', outContext)
                           end

                           # extended element info - rule
                           s = hExtension[:rule]
                           unless s.nil?
                              @xml.tag!('gmd:rule') do
                                 @xml.tag!('gco:CharacterString', s)
                              end
                           end
                           if s.nil?
                              @NameSpace.issueWarning(104, 'gmd:rule', outContext)
                           end

                           # extended element info - rationale []
                           aRations = hExtension[:rationales]
                           aRations.each do |ration|
                              @xml.tag!('gmd:rationale') do
                                 @xml.tag!('gco:CharacterString', ration)
                              end
                           end
                           if aRations.empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('gmd:rationale')
                           end

                           # extended element info - source [] (required)
                           # only allowing 1 for now
                           role = hExtension[:sourceRole]
                           unless role.nil?
                              @xml.tag!('gmd:source') do
                                 @xml.tag!('gmd:CI_ResponsibleParty') do
                                    orgName = hExtension[:sourceOrganization]
                                    unless orgName.nil?
                                       @xml.tag!('gmd:organisationName') do
                                          @xml.tag!('gco:CharacterString', orgName)
                                       end
                                    end
                                    uri = hExtension[:sourceURI]
                                    unless uri.nil?
                                       @xml.tag!('gmd:contactInfo') do
                                          @xml.tag!('gmd:CI_Contact') do
                                             @xml.tag!('gmd:onlineResource') do
                                                @xml.tag!('gmd:CI_OnlineResource') do
                                                   @xml.tag!('gmd:linkage') do
                                                      @xml.tag!('gmd:URL', uri)
                                                   end
                                                end
                                             end
                                          end
                                       end
                                    end
                                    @xml.tag!('gmd:role') do
                                       codelistClass.writeXML('gmd', 'iso_role', role)
                                    end
                                 end
                              end
                           end
                           if role.nil?
                              @NameSpace.issueWarning(105, 'gmd:source', outContext)
                           end

                        end # gmd:MD_ExtendedElementInformation tag
                     end # gmd:extendedElementInformation
                  end # gmd:MD_MetadataExtensionInformation
               end # writeXML
            end # MD_MetadataExtensionInformation class

         end
      end
   end
end
