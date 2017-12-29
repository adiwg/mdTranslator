# Reader - fgdc to internal data structure
# unpack fgdc taxonomy system

# History:
#  Stan Smith 2017-09-20 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'
require_relative 'module_contact'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TaxonSystem

               def self.unpack(xSystem, hTaxonomy, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # taxonomy bio.2.1 (classsys) - taxonomic classification authority []
                  # -> resourceInfo.taxonomy.taxonSystem
                  axTaxClass = xSystem.xpath('./classsys')
                  unless axTaxClass.empty?
                     axTaxClass.each do |xTaxClass|

                        hTaxonSystem = intMetadataClass.newTaxonSystem

                        # taxonomy bio.2.1.1 (classcit) - taxonomic classification citation {citation}
                        # -> resourceInfo.taxonomy.taxonSystem.citation
                        xCitation = xTaxClass.xpath('./classcit')
                        unless xCitation.empty?
                           hCitation = Citation.unpack(xCitation, hResponseObj)
                           unless hCitation.nil?
                              hTaxonSystem[:citation] = hCitation
                           end
                        end

                        # taxonomy bio.2.1.2 (classmod) - taxonomic classification modifications
                        # -> resourceInfo.taxonomy.taxonSystem.modifications
                        modifications = xTaxClass.xpath('./classmod').text
                        unless modifications.empty?
                           hTaxonSystem[:modifications] = modifications
                        end

                        hTaxonomy[:taxonSystem] << hTaxonSystem

                     end
                  end

                  # taxonomy bio.2.2 (idref) - taxonomic identification reference [] {identifier}
                  # -> resourceInfo.taxonomy.idReferences.authority
                  axTaxRef = xSystem.xpath('./idref')
                  unless axTaxRef.empty?
                     axTaxRef.each do |xTaxRef|
                        hCitation = Citation.unpack(xTaxRef, hResponseObj)
                        unless hCitation.nil?
                           hIdentifier = intMetadataClass.newIdentifier
                           hIdentifier[:identifier] = 'none'
                           hIdentifier[:citation] = hCitation
                           hTaxonomy[:idReferences] << hIdentifier
                        end
                     end
                  end

                  # taxonomy bio.2.3 (ider) - taxonomic identifier [] {contact}
                  # -> resourceInfo.taxonomy.observers.responsibility
                  axObserver = xSystem.xpath('./ider')
                  unless axObserver.empty?
                     axObserver.each do |xObserver|
                        hResponsibility = Contact.unpack(xObserver, hResponseObj)
                        unless hResponsibility.nil?
                           hResponsibility[:roleName] = 'observer'
                           hTaxonomy[:observers] << hResponsibility
                        end
                     end
                  end

                  # taxonomy bio.2.4 (taxonpro) - taxonomic procedures
                  # -> resourceInfo.taxonomy.idProcedure
                  procedures = xSystem.xpath('./taxonpro').text
                  unless procedures.empty?
                     hTaxonomy[:idProcedure] = procedures
                  end

                  # taxonomy bio.2.5 (taxoncom) - taxonomic completeness
                  # -> resourceInfo.taxonomy.idCompleteness
                  completeness = xSystem.xpath('./taxoncom').text
                  unless completeness.empty?
                     hTaxonomy[:idCompleteness] = completeness
                  end

                  # taxonomy bio.2.6 (vouchers) - vouchers []
                  # -> resourceInfo.taxonomy.vouchers
                  axVoucher = xSystem.xpath('./vouchers')
                  unless axVoucher.empty?
                     axVoucher.each do |xVoucher|

                        hVoucher = intMetadataClass.newTaxonVoucher

                        # taxonomy bio.2.6.1 (specimen) - specimen
                        # -> resourceInfo.taxonomy.vouchers.specimen
                        specimen = xVoucher.xpath('./specimen').text
                        unless specimen.empty?
                           hVoucher[:specimen] = specimen
                        end

                        # taxonomy bio.2.6.2 (reposit) - repository {contact}
                        # -> resourceInfo.taxonomy.vouchers.repository
                        xRepository = xVoucher.xpath('./reposit')
                        unless xRepository.empty?
                           hResponsibility = Contact.unpack(xRepository, hResponseObj)
                           unless hResponsibility.nil?
                              hResponsibility[:roleName] = 'curator'
                              hVoucher[:repository] = hResponsibility
                           end
                        end

                        hTaxonomy[:vouchers] << hVoucher

                     end
                  end

                  return hTaxonomy

               end
            end

         end
      end
   end
end
