# ISO <<Class>> CI_Citation
# writer output in XML

# History:
# 	Stan Smith 2013-08-26 original script
# 	Stan Smith 2013-12-30 added ISBN, ISSN
#   Stan Smith 2014-05-16 modified for JSON schema 0.4.0
#   Stan Smith 2014-05-16 added MD_Identifier
#   Stan Smith 2014-05-28 modified for json schema 0.5.0
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-08-18 modify identifier section for schema 0.6.0
#   Stan Smith 2014-08-18 process isbn and issn from identifier section per 0.6.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require 'code_presentationForm'
require 'class_responsibleParty'
require 'class_date'
require 'class_identifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class CI_Citation

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hCitation)

                        # classes used
                        presFormClass = $IsoNS::CI_PresentationFormCode.new(@xml)
                        rPartyClass = $IsoNS::CI_ResponsibleParty.new(@xml)
                        dateClass = $IsoNS::CI_Date.new(@xml)
                        idClass = $IsoNS::MD_Identifier.new(@xml)

                        @xml.tag!('gmd:CI_Citation') do

                            # citation - title - required
                            s = hCitation[:citTitle]
                            if s.nil?
                                @xml.tag!('gmd:title', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:title') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # citation - date - required
                            aDate = hCitation[:citDate]
                            if aDate.empty?
                                @xml.tag!('gmd:date', {'gco:nilReason' => 'missing'})
                            else
                                aDate.each do |hDate|
                                    @xml.tag!('gmd:date') do
                                        dateClass.writeXML(hDate)
                                    end
                                end
                            end

                            # citation - edition
                            s = hCitation[:citEdition]
                            if !s.nil?
                                @xml.tag!('gmd:edition') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:edition')
                            end

                            # citation - resource identifiers - MD_Identifier
                            # do not process ISBN and ISSN as MD_identifier(s)
                            # ... these are processed separately in ISO 19115-2
                            aResIDs = hCitation[:citResourceIds]
                            if !aResIDs.empty?
                                aResIDs.each do |hResID|
                                    if !hResID[:identifierType].nil?
                                        next if hResID[:identifierType].downcase == 'isbn'
                                        next if hResID[:identifierType].downcase == 'issn'
                                    end
                                    @xml.tag!('gmd:identifier') do
                                        idClass.writeXML(hResID)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:identifier')
                            end

                            # citation - cited responsible party
                            aResParty = hCitation[:citResponsibleParty]
                            if !aResParty.empty?
                                aResParty.each do |rParty|
                                    @xml.tag!('gmd:citedResponsibleParty') do
                                        rPartyClass.writeXML(rParty)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:citedResponsibleParty')
                            end

                            # citation - presentation forms - CI_PresentationFormCode
                            aPresForms = hCitation[:citResourceForms]
                            if !aPresForms.empty?
                                aPresForms.each do |presForm|
                                    @xml.tag!('gmd:presentationForm') do
                                        presFormClass.writeXML(presForm)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:presentationForm')
                            end

                            # citation - ISBN
                            needTag = true
                            aResIDs = hCitation[:citResourceIds]
                            if !aResIDs.empty?
                                aResIDs.each do |hResID|
                                    if !hResID[:identifierType].nil?
                                        if hResID[:identifierType].downcase == 'isbn'
                                            s = hResID[:identifier]
                                            if !s.nil?
                                                @xml.tag!('gmd:ISBN') do
                                                    @xml.tag!('gco:CharacterString', s)
                                                    needTag = false
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if $showAllTags && needTag
                                @xml.tag!('gmd:ISBN')
                            end

                            # citation - ISSN
                            needTag = true
                            aResIDs = hCitation[:citResourceIds]
                            if !aResIDs.empty?
                                aResIDs.each do |hResID|
                                    if !hResID[:identifierType].nil?
                                        if hResID[:identifierType].downcase == 'issn'
                                            s = hResID[:identifier]
                                            if !s.nil?
                                                @xml.tag!('gmd:ISSN') do
                                                    @xml.tag!('gco:CharacterString', s)
                                                    needTag = false
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if $showAllTags && needTag
                                @xml.tag!('gmd:ISSN')
                            end

                        end

                    end

                end

            end
        end
    end
end
