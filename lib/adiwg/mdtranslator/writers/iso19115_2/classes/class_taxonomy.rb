# ISO <<Class>> MD_TaxonSys
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-09 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-19 original script.

require_relative 'class_taxonomicSystem'
require_relative 'class_rsIdentifier'
require_relative 'class_responsibleParty'
require_relative 'class_vouchers'
require_relative 'class_taxonomicClassification'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_TaxonSys

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hSystem)

                        # classes used
                        taxonomicClass =  TaxonomicSystem.new(@xml, @hResponseObj)
                        identifierClass =  RS_Identifier.new(@xml, @hResponseObj)
                        partyClass =  CI_ResponsibleParty.new(@xml, @hResponseObj)
                        voucherClass =  MD_Vouchers.new(@xml, @hResponseObj)
                        taxonClass =  MD_TaxonCl.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:MD_TaxonSys') do

                            # taxon system - classification system (required) [{TaxonomicSystem}]
                            aSystems = hSystem[:taxonSystem]
                            aSystems.each do |hSystem|
                                @xml.tag!('gmd:classSys') do
                                    taxonomicClass.writeXML(hSystem)
                                end
                            end
                            if aSystems.empty?
                                @xml.tag!('gmd:classSys', {'gco:nilReason' => 'missing'})
                            end

                            # taxon system - general scope
                            s = hSystem[:generalScope]
                            unless s.nil?
                                @xml.tag!('gmd:taxongen') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:taxongen')
                            end

                            # taxon system - identification reference (required) [{RS_Identifier}]
                            aIdentifier = hSystem[:idReferences]
                            aIdentifier.each do |hIdentifier|
                                unless hIdentifier.empty?
                                    @xml.tag!('gmd:idref') do
                                        identifierClass.writeXML(hIdentifier)
                                    end
                                end
                            end
                            if aIdentifier.empty?
                                @xml.tag!('gmd:idref', {'gco:nilReason' => 'missing'})
                            end

                            # taxon system - observers [{CI_ResponsibleParty}]
                            aObservers = hSystem[:observers]
                            aObservers.each do |hObserver|
                                role = hObserver[:roleName]
                                aParties = hObserver[:parties]
                                aParties.each do |hParty|
                                    @xml.tag!('gmd:obs') do
                                        partyClass.writeXML(role, hParty)
                                    end
                                end
                            end
                            if aObservers.empty?
                                @xml.tag!('gmd:obs', {'gco:nilReason' => 'missing'})
                            end

                            # taxon system - taxon identification procedures (required)
                            s = hSystem[:idProcedure]
                            if s.nil?
                                @xml.tag!('gmd:taxonpro', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:taxonpro') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end

                            # taxon system - completeness
                            s = hSystem[:idCompleteness]
                            unless s.nil?
                                @xml.tag!('gmd:taxoncom') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            end
                            if s.nil? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:taxoncom')
                            end

                            # taxon system - voucher {MD_Voucher}
                            aVouchers = hSystem[:vouchers]
                            unless aVouchers.empty?
                                unless aVouchers[0].nil?
                                    @xml.tag!('gmd:voucher') do
                                        voucherClass.writeXML(aVouchers[0])
                                    end
                                end
                            end
                            if aVouchers.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:voucher')
                            end

                            # taxon system - taxonomy classification [] (required)
                            hTaxClass = hSystem[:taxonClass]
                            unless hTaxClass.empty?
                                @xml.tag!('gmd:taxonCl') do
                                    taxonClass.writeXML(hTaxClass)
                                end
                            end
                            if hTaxClass.empty?
                                @xml.tag!('gmd:taxonCl', {'gco:nilReason' => 'missing'})
                            end

                        end # gmd:MD_TaxonSys tag
                    end # writeXML
                end # MD_TaxonSys class

            end
        end
    end
end
