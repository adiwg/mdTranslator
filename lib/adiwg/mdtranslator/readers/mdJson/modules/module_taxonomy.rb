# unpack citation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-19 refactored error and warning messaging
#  Stan Smith 2016-10-22 original script

require_relative 'module_taxonomicSystem'
require_relative 'module_identifier'
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
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson taxonomy object is empty'
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
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson taxonomy taxonomic classification system object is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # taxonomy - general taxonomic scope
                  if hTaxonomy.has_key?('generalScope')
                     unless hTaxonomy['generalScope'] == ''
                        intTaxonomy[:generalScope] = hTaxonomy['generalScope']
                     end
                  end

                  # taxonomy - identification reference (required) [{identifier}]
                  if hTaxonomy.has_key?('identificationReference')
                     aItems = hTaxonomy['identificationReference']
                     aItems.each do |hItem|
                        unless hItem.empty?
                           hReturn = Identifier.unpack(hItem, responseObj)
                           unless hReturn.nil?
                              intTaxonomy[:idReferences] << hReturn
                           end
                        end
                     end
                  end
                  if intTaxonomy[:idReferences].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson taxonomy identification reference object is missing'
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
                     unless hTaxonomy['identificationProcedure'] == ''
                        intTaxonomy[:idProcedure] = hTaxonomy['identificationProcedure']
                     end
                  end
                  if intTaxonomy[:idProcedure].nil? || intTaxonomy[:idProcedure] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson taxonomy identification procedure is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # taxonomy - identification completeness
                  if hTaxonomy.has_key?('identificationCompleteness')
                     unless hTaxonomy['identificationCompleteness'] == ''
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

                  # taxonomy - taxonomic classification {taxonomicClassification} (required)
                  if hTaxonomy.has_key?('taxonomicClassification')
                     item = hTaxonomy['taxonomicClassification']
                     unless item.empty?
                        hReturn = TaxonomicClassification.unpack(item, responseObj)
                        unless hReturn.nil?
                           intTaxonomy[:taxonClass] = hReturn
                        end
                     end
                  end
                  if intTaxonomy[:taxonClass].empty?
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson taxonomic classification is missing'
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
