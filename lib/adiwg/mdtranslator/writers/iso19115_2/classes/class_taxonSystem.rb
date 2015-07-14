# ISO <<Class>> MD_TaxonSys
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script.
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_citation'
require_relative 'class_responsibleParty'
require_relative 'class_vouchers'
require_relative 'class_taxonClassification'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_TaxonSys

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hTaxonSys)

                        # classes used
                        citationClass =  CI_Citation.new(@xml, @responseObj)
                        rPartyClass =  CI_ResponsibleParty.new(@xml, @responseObj)
                        tVoucherClass =  MD_Vouchers.new(@xml, @responseObj)
                        tClassClass =  MD_TaxonCl.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_TaxonSys') do

                            # taxon system - class system citations - required - CI_Citation
                            aTaxClassCits = hTaxonSys[:taxClassSys]
                            if aTaxClassCits.empty?
                                @xml.tag!('gmd:classSys', {'gco:nilReason' => 'missing'})
                            else
                                aTaxClassCits.each do |hCitation|
                                    @xml.tag!('gmd:classSys') do
                                        citationClass.writeXML(hCitation)
                                    end
                                end
                            end

                            # taxon system - general scope
                            s = hTaxonSys[:taxGeneralScope]
                            if !s.nil?
                                @xml.tag!('gmd:taxongen') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:taxongen')
                            end

                            # taxon system - identification reference - required
                            @xml.tag!('gmd:idref', {'gco:nilReason' => 'unknown'})

                            # taxon system - observers - CI_ResponsibleParty
                            aObservers = hTaxonSys[:taxObservers]
                            if !aObservers.empty?
                                aObservers.each do |rParty|
                                    @xml.tag!('gmd:obs') do
                                        rPartyClass.writeXML(rParty)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:obs')
                            end

                            # taxon system - taxon identification procedures - required
                            s = hTaxonSys[:taxIdProcedures]
                            if s.nil?
                                @xml.tag!('gmd:taxonpro', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonpro') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # taxon system - voucher - MD_Voucher
                            hTaxVoucher = hTaxonSys[:taxVoucher]
                            if !hTaxVoucher.empty?
                                @xml.tag!('gmd:voucher') do
                                    tVoucherClass.writeXML(hTaxVoucher)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:voucher')
                            end

                            # taxon system - taxonomy classification - required
                            aTaxClass = hTaxonSys[:taxClasses]
                            if aTaxClass.empty?
                                @xml.tag!('gmd:taxonCl', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonCl') do
                                    tClassClass.writeXML(aTaxClass)
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
