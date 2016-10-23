# unpack taxonomic classification
# Reader - ADIwg JSON to internal data structure

# History:
#   Stan Smith 2016-10-22 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_taxonomicClassification')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TaxonomicClassification

                    def self.unpack(hTaxClass, responseObj)

                        # return nil object if input is empty
                        if hTaxClass.empty?
                            responseObj[:readerExecutionMessages] << 'Taxonomic Classification object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intTaxClass = intMetadataClass.newTaxonClass

                        # taxonomic classification - taxon rank (required)
                        if hTaxClass.has_key?('taxonomicRank')
                            intTaxClass[:taxonRank] = hTaxClass['taxonomicRank']
                        end
                        if intTaxClass[:taxonRank].nil? || intTaxClass[:taxonRank] == ''
                            responseObj[:readerExecutionMessages] << 'Taxonomic Classification attribute taxonomicRank is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # taxonomic classification - latin name (required)
                        if hTaxClass.has_key?('latinName')
                            intTaxClass[:taxonValue] = hTaxClass['latinName']
                        end
                        if intTaxClass[:taxonValue].nil? || intTaxClass[:taxonValue] == ''
                            responseObj[:readerExecutionMessages] << 'Taxonomic Classification attribute latinName is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # taxonomic classification - common name []
                        if hTaxClass.has_key?('commonName')
                            hTaxClass['commonName'].each do |item|
                                if item != ''
                                    intTaxClass[:commonName] << item
                                end
                            end
                        end

                         # taxonomic classification - taxonomic classification [taxonomicClassification]
                        if hTaxClass.has_key?('taxonomicClassification')
                            aItems = hTaxClass['taxonomicClassification']
                            aItems.each do |item|
                                hReturn = TaxonomicClassification.unpack(item, responseObj)
                                unless hReturn.nil?
                                    intTaxClass[:taxonClass] << hReturn
                                end
                            end
                        end

                        return intTaxClass

                    end

                end

            end
        end
    end
end
