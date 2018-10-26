# unpack citation
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-10-27 identification procedure no longer required
#  Stan Smith 2018-10-19 refactor taxonomic classification as array
#  Stan Smith 2018-06-26 refactored error and warning messaging
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

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hTaxonomy.empty?
                     @MessagePath.issueWarning(830, responseObj)
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
                     @MessagePath.issueError(831, responseObj)
                  end

                  # taxonomy - general taxonomic scope
                  if hTaxonomy.has_key?('generalScope')
                     unless hTaxonomy['generalScope'] == ''
                        intTaxonomy[:generalScope] = hTaxonomy['generalScope']
                     end
                  end

                  # taxonomy - identification reference [{identifier}]
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

                  # taxonomy - identification procedure
                  if hTaxonomy.has_key?('identificationProcedure')
                     unless hTaxonomy['identificationProcedure'] == ''
                        intTaxonomy[:idProcedure] = hTaxonomy['identificationProcedure']
                     end
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

                  # taxonomy - taxonomic classification [] {taxonomicClassification} (required)
                  # support deprecated taxonomicClassification{}
                  if hTaxonomy.has_key?('taxonomicClassification')
                     aItems = hTaxonomy['taxonomicClassification']
                     if aItems.is_a?(Array)
                        aItems.each do |item|
                           hReturn = TaxonomicClassification.unpack(item, responseObj)
                           unless hReturn.nil?
                              intTaxonomy[:taxonClasses] << hReturn
                           end
                        end
                     else
                        hReturn = TaxonomicClassification.unpack(aItems, responseObj)
                        unless hReturn.nil?
                           intTaxonomy[:taxonClasses] << hReturn
                        end
                        @MessagePath.issueNotice(834, responseObj)
                     end
                  end
                  if intTaxonomy[:taxonClasses].empty?
                     @MessagePath.issueError(833, responseObj)
                  end

                  return intTaxonomy

               end

            end

         end
      end
   end
end
