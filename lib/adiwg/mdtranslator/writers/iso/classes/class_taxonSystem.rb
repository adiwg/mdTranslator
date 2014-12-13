# ISO <<Class>> MD_TaxonSys
# writer output in XML

# History:
# 	Stan Smith 2013-11-19 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_citation'
require 'class_responsibleParty'
require 'class_vouchers'
require 'class_taxonClassification'

class MD_TaxonSys

    def initialize(xml)
        @xml = xml
    end

    def writeXML(hTaxonSys)

        # classes used
        citationClass = CI_Citation.new(@xml)
        rPartyClass = CI_ResponsibleParty.new(@xml)
        tVoucherClass = MD_Vouchers.new(@xml)
        tClassClass = MD_TaxonCl.new(@xml)

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
            elsif $showAllTags
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
            elsif $showAllTags
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
            elsif $showAllTags
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
