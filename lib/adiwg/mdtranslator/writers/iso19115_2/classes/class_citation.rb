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
#   Stan Smith 2014-08-18 process isbn and ISSN from identifier section per 0.6.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_date'
require_relative 'class_identifier'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class CI_Citation

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hCitation)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @responseObj)
                        rPartyClass =  CI_ResponsibleParty.new(@xml, @responseObj)
                        dateClass =  CI_Date.new(@xml, @responseObj)
                        idClass =  MD_Identifier.new(@xml, @responseObj)

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
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:citedResponsibleParty')
                            end

                            # citation - presentation forms - CI_PresentationFormCode
                            aPresForms = hCitation[:citResourceForms]
                            if !aPresForms.empty?
                                aPresForms.each do |presForm|
                                    @xml.tag!('gmd:presentationForm') do
                                        codelistClass.writeXML('iso_presentationForm',presForm)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
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
                            if @responseObj[:writerShowTags] && needTag
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
                            if @responseObj[:writerShowTags] && needTag
                                @xml.tag!('gmd:ISSN')
                            end

                        end

                    end

                end

            end
        end
    end
end
