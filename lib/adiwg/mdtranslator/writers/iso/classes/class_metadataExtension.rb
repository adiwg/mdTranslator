# ISO <<Class>> MD_MetadataExtensionInformation
# writer output in XML

# History:
# 	Stan Smith 2013-11-22 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_codelist'
require 'class_enumerationList'
require 'class_onlineResource'
require 'class_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_MetadataExtensionInformation

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hExtension)

                        # classes used
                        codelistClass = $IsoNS::MD_Codelist.new(@xml, @responseObj)
                        enumerationClass = $IsoNS::MD_EnumerationList.new(@xml, @responseObj)
                        olResClass = $IsoNS::CI_OnlineResource.new(@xml, @responseObj)
                        rPartyClass = $IsoNS::CI_ResponsibleParty.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_MetadataExtensionInformation') do

                            # metadata extension - online resource - CI_OnLineResource
                            hOLResource = hExtension[:onLineResource]
                            if !hOLResource.empty?
                                @xml.tag!('gmd:extensionOnLineResource') do
                                    olResClass.writeXML(hOLResource)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:extensionOnLineResource')
                            end

                            # metadata extension = extended element information
                            @xml.tag!('gmd:extendedElementInformation') do
                                @xml.tag!('gmd:MD_ExtendedElementInformation') do

                                    # extended element info - name - required
                                    s = hExtension[:extName]
                                    if s.nil?
                                        @xml.tag!('gmd:name', {'gco:nilReason' => 'missing'})
                                    else
                                        @xml.tag!('gmd:name') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    end

                                    # extended element info - short name
                                    s = hExtension[:extShortName]
                                    if !s.nil?
                                        @xml.tag!('gmd:shortName') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:shortName')
                                    end

                                    # extended element info - definition - required
                                    s = hExtension[:extDefinition]
                                    if s.nil?
                                        @xml.tag!('gmd:definition', {'gco:nilReason' => 'missing'})
                                    else
                                        @xml.tag!('gmd:definition') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    end

                                    # extended element info - obligation
                                    s = hExtension[:obligation]
                                    if !s.nil?
                                        @xml.tag!('gmd:obligation') do
                                            enumerationClass.writeXML('iso_obligation',s)
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:obligation')
                                    end

                                    # extended element info - data type - required
                                    s = hExtension[:dataType]
                                    if s.nil?
                                        @xml.tag!('gmd:dataType', {'gco:nilReason' => 'missing'})
                                    else
                                        @xml.tag!('gmd:dataType') do
                                            codelistClass.writeXML('iso_dataType',s)
                                        end
                                    end

                                    # extended element info - maximum occurrence
                                    s = hExtension[:maxOccurrence]
                                    if !s.nil?
                                        @xml.tag!('gmd:maximumOccurrence') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    elsif @responseObj[:writerShowTags]
                                        @xml.tag!('gmd:maximumOccurrence')
                                    end

                                    # extended element info - parent entity - required
                                    aParents = hExtension[:parentEntities]
                                    if aParents.empty?
                                        @xml.tag!('gmd:parentEntity', {'gco:nilReason' => 'missing'})
                                    else
                                        aParents.each do |parent|
                                            @xml.tag!('gmd:parentEntity') do
                                                @xml.tag!('gco:CharacterString', parent)
                                            end
                                        end
                                    end

                                    # extended element info - rule
                                    s = hExtension[:rule]
                                    if s.nil?
                                        @xml.tag!('gmd:rule', {'gco:nilReason' => 'missing'})
                                    else
                                        @xml.tag!('gmd:rule') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    end

                                    # extended element info - rationale
                                    aRations = hExtension[:rationales]
                                    if aRations.empty?
                                        @xml.tag!('gmd:rationale')
                                    else
                                        aRations.each do |ration|
                                            @xml.tag!('gmd:rationale') do
                                                @xml.tag!('gco:CharacterString', ration)
                                            end
                                        end
                                    end

                                    # extended element info - source - CI_ResponsibleParty
                                    aSources = hExtension[:extSources]
                                    if aSources.empty?
                                        @xml.tag!('gmd:source', {'gco:nilReason' => 'missing'})
                                    else
                                        aSources.each do |hSource|
                                            @xml.tag!('gmd:source') do
                                                rPartyClass.writeXML(hSource)
                                            end
                                        end
                                    end

                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
