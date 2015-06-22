# ISO 19110 <<Class>> FC_FeatureCatalogue
# writer output in XML

# History:
# 	Stan Smith 2013-12-01 original script
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-29 set builder object '@xml' into string 'metadata'
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_responsibleParty'
require 'class_featureType'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                class FC_FeatureCatalogue

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(intObj)
                        $IsoNS = ADIWG::Mdtranslator::Writers::Iso

                        # classes used
                        rPartyClass = $IsoNS::CI_ResponsibleParty.new(@xml, @responseObj)
                        featureClass = $IsoNS::FC_FeatureType.new(@xml, @responseObj)

                        intDataDictionary = intObj[:dataDictionary][0]
                        hDDInfo = intDataDictionary[:dictionaryInfo]
                        aEntities = intDataDictionary[:entities]
                        hCitation = hDDInfo[:dictCitation]

                        $intContactList = intObj[:contacts]
                        $domainList = intDataDictionary[:domains]

                        # document head
                        metadata = @xml.instruct! :xml, encoding: 'UTF-8'
                        @xml.comment!('core gfc based instance document for ISO 19110')
                        @xml.comment!('metadata file constructed using mdTranslator')
                        @xml.comment!('mdTranslator software is an open-source project sponsored by the Alaska Data Integration working group (ADIwg)')
                        @xml.comment!('Alaska Data Integration working group is not responsible for the metadata content')
                        @xml.comment!('mdTranslator and other metadata tools available at https://github.com/adiwg')
                        @xml.tag!('gfc:FC_FeatureCatalogue', {'xmlns:gmi' => 'http://www.isotc211.org/2005/gmi',
                                                              'xmlns:gmd' => 'http://www.isotc211.org/2005/gmd',
                                                              'xmlns:gco' => 'http://www.isotc211.org/2005/gco',
                                                              'xmlns:gml' => 'http://www.opengis.net/gml/3.2',
                                                              'xmlns:gsr' => 'http://www.isotc211.org/2005/gsr',
                                                              'xmlns:gss' => 'http://www.isotc211.org/2005/gss',
                                                              'xmlns:gst' => 'http://www.isotc211.org/2005/gst',
                                                              'xmlns:gmx' => 'http://www.isotc211.org/2005/gmx',
                                                              'xmlns:gfc' => 'http://www.isotc211.org/2005/gfc',
                                                              'xmlns:xlink' => 'http://www.w3.org/1999/xlink',
                                                              'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance',
                                                              'xsi:schemaLocation' => 'http://www.isotc211.org/2005/gfc ftp://ftp.ncddc.noaa.gov/pub/Metadata/Online_ISO_Training/Intro_to_ISO/schemas/ISObio/gfc/gfc.xsd'}) do

                            # feature catalogue information - name - required
                            # name is pulled from citation title in data dictionary information section
                            s = nil
                            if hCitation
                                if hCitation[:citTitle]
                                    s = hCitation[:citTitle]
                                end
                            end
                            if !s.nil?
                                @xml.tag!('gmx:name') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gmx:name', {'gco:nilReason' => 'missing'})
                            end

                            # feature catalogue information - scope - required []
                            # only a single instance is being supported
                            s = hDDInfo[:dictResourceType]
                            if !s.nil?
                                @xml.tag!('gmx:scope') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gmx:scope', {'gco:nilReason' => 'missing'})
                            end

                            # feature catalogue information - field of application []
                            # only a single instance is being supported
                            s = hDDInfo[:dictDescription]
                            if !s.nil?
                                @xml.tag!('gmx:fieldOfApplication') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmx:fieldOfApplication')
                            end

                            # feature catalogue information - version number - required
                            # version number is taken from citation citEdition in data dictionary the info section
                            s = nil
                            if hCitation
                                if hCitation[:citEdition]
                                    s = hCitation[:citEdition]
                                end
                            end
                            if !s.nil?
                                @xml.tag!('gmx:versionNumber') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            else
                                @xml.tag!('gmx:versionNumber', {'gco:nilReason' => 'missing'})
                            end

                            # feature catalogue information - version date - required
                            # version number is taken from citation citEdition in data dictionary the info section
                            # citation allows an array of citation dates, only one can be used as version date
                            vDate = nil
                            if hCitation
                                if hCitation[:citDate]
                                    if hCitation[:citDate][0]
                                        hDate = hCitation[:citDate][0]
                                        unless hDate.empty?
                                            dateTime = hDate[:dateTime]
                                            dateRes = hDate[:dateResolution]
                                            unless dateTime.nil?
                                                vDate = AdiwgDateTimeFun.stringDateFromDateTime(dateTime, dateRes)
                                            end
                                        end
                                    end
                                end
                            end
                            if vDate.nil?
                                @xml.tag!('gmx:versionDate', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmx:versionDate') do
                                    @xml.tag!('gco:Date', vDate)
                                end
                            end

                            # feature catalogue information - language
                            s = hDDInfo[:dictLanguage]
                            if !s.nil?
                                @xml.tag!('gmx:language') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmx:language')
                            end

                            # feature catalogue information - producer - required - CI_ResponsibleParty
                            # producer is taken from citation responsibleParty in data dictionary the info section
                            # citation allows an array of responsible parties, only one can be used as producer
                            rParty = nil
                            if hCitation
                                if hCitation[:citResponsibleParty]
                                    if hCitation[:citResponsibleParty][0]
                                        rParty = hCitation[:citResponsibleParty][0]
                                    end
                                end
                            end
                            if rParty.nil? || rParty.empty?
                                @xml.tag!('gfc:producer', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gfc:producer') do
                                    rPartyClass.writeXML(rParty)
                                end
                            end

                            # feature catalogue feature type - required
                            # use feature type to represent entities
                            if !aEntities.empty?
                                aEntities.each do |hEntity|
                                    @xml.tag!('gfc:featureType') do
                                        featureClass.writeXML(hEntity)
                                    end
                                end
                            else
                                @xml.tag!('gfc:featureType', {'gco:nilReason' => 'missing'})
                            end

                            return metadata
                        end

                    end

                end

            end
        end
    end
end

