# unpack citation
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-22 original script

require_relative 'module_taxonomicSystem'
require_relative 'module_responsibleParty'
require_relative 'module_voucher'
require_relative 'module_taxonomicClassification'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Taxonomy

                    def self.unpack(hTaxonomy, responseObj)


                        # return nil object if input is empty
                        if hTaxonomy.empty?
                            responseObj[:readerExecutionMessages] << 'Taxonomy object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTaxonomy = intMetadataClass.newTaxonomy

                        # taxonomy - classification system [{TaxonomySystem}] (required)
                        if hTaxonomy.has_key?('taxonomicSystem')
                            aItems = hTaxonomy['taxonomicSystem']
                            aItems.each do |item|
                                hReturn = TaxonomicSystem.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxonomy[:taxonSystem] << hReturn
                                end
                            end
                        end
                        if intTaxonomy[:taxonSystem].empty?
                            responseObj[:readerExecutionMessages] << 'Taxonomy object is missing classificationSystem'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # taxonomy - general taxonomic scope
                        if hTaxonomy.has_key?('generalScope')
                            if hTaxonomy['generalScope'] != ''
                                intTaxonomy[:generalScope] = hTaxonomy['generalScope']
                            end
                        end

                        # taxonomy - identification reference [citation] (required)
                        if hTaxonomy.has_key?('identificationReference')
                            aItems = hTaxonomy['identificationReference']
                            aItems.each do |item|
                                hReturn = Citation.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxonomy[:idReferences] << hReturn
                                end
                            end
                        end
                        if intTaxonomy[:idReferences].empty?
                            responseObj[:readerExecutionMessages] << 'Taxonomy object is missing identificationReference'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # taxonomy - observer [responsibleParty]
                        if hTaxonomy.has_key?('observer')
                            aItems = hTaxonomy['observer']
                            aItems.each do |item|
                                hReturn = ResponsibleParty.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxonomy[:observers] << hReturn
                                end
                            end
                        end

                        # taxonomy - identification procedure (required)
                        if hTaxonomy.has_key?('identificationProcedure')
                            if hTaxonomy['identificationProcedure'] != ''
                                intTaxonomy[:idProcedure] = hTaxonomy['identificationProcedure']
                            end
                        end
                        if intTaxonomy[:idProcedure].nil? || intTaxonomy[:idProcedure] == ''
                            responseObj[:readerExecutionMessages] << 'Taxonomy object is missing identificationProcedure'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # taxonomy - identification completeness
                        if hTaxonomy.has_key?('identificationCompleteness')
                            if hTaxonomy['identificationCompleteness'] != ''
                                intTaxonomy[:idCompleteness] = hTaxonomy['identificationCompleteness']
                            end
                        end

                        # taxonomy - voucher []
                        if hTaxonomy.has_key?('voucher')
                            aItems = hTaxonomy['voucher']
                            aItems.each do |item|
                                hReturn = Voucher.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxonomy[:vouchers] << hReturn
                                end
                            end
                        end

                        # taxonomy - taxonomic classification [taxonomicClassification] (required)
                        if hTaxonomy.has_key?('taxonomicClassification')
                            aItems = hTaxonomy['taxonomicClassification']
                            aItems.each do |item|
                                hReturn = TaxonomicClassification.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxonomy[:taxonClasses] << hReturn
                                end
                            end
                        end
                        if intTaxonomy[:taxonClasses].empty?
                            responseObj[:readerExecutionMessages] << 'Taxonomy object is missing taxonomicClassification'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intTaxonomy

                    end

                end

            end
        end
    end
end
