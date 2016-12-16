# ISO <<Class>> MD_TaxonCl
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-09 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2013-11-19 original script.

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_TaxonCl

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hTaxon)

                        @xml.tag!('gmd:MD_TaxonCl') do

                            # taxon classification - common name []
                            aCommon = hTaxon[:commonName]
                            aCommon.each do |common|
                                @xml.tag!('gmd:common') do
                                    @xml.tag!('gco:CharacterString', common)
                                end
                            end
                            if aCommon.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:common')
                            end

                            # taxon classification - taxon rank name (required)
                            s = hTaxon[:taxonRank]
                            if s.nil?
                                @xml.tag!('gmd:taxonrn', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonrn') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # taxon classification - taxon rank value (required)
                            s = hTaxon[:taxonValue]
                            if s.nil?
                                @xml.tag!('gmd:taxonrv', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonrv') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # taxon classification - classification [{MD_TaxonCl}]
                            aClasses = hTaxon[:taxonClass]
                            aClasses.each do |hClass|
                                taxonClass = MD_TaxonCl.new(@xml, @hResponseObj)
                                taxonClass.writeXML(hClass)
                            end

                        end # gmd:MD_TaxonCl tag
                    end # writeXML
                end # MD_TaxonCl class

            end
        end
    end
end