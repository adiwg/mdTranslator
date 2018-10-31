# FGDC <<Class>> TaxonomySystem
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-12-13 original script

require_relative '../fgdc_writer'
require_relative 'class_citation'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class TaxonomySystem

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hTaxonomy)

                  # classes used
                  citationClass = Citation.new(@xml, @hResponseObj)
                  contactClass = Contact.new(@xml, @hResponseObj)

                  # taxonomic system (classsys) - classification system [] (required)
                  hTaxonomy[:taxonSystem].each do |hSystem|
                     @xml.tag!('classsys') do

                        # taxonomic system (classcit) - system citation (required) {citation}
                        unless hSystem[:citation].empty?
                           @xml.tag!('classcit') do
                              citationClass.writeXML(hSystem[:citation], [], 'taxonomic classification system')
                           end
                        end
                        if hSystem[:citation].empty?
                           @NameSpace.issueWarning(430, nil)
                        end

                        # taxonomic system (classmod) - system modifications
                        unless hSystem[:modifications].nil?
                           @xml.tag!('classmod', hSystem[:modifications])
                        end
                        if hSystem[:modifications].nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('classmod')
                        end

                     end
                  end
                  if hTaxonomy[:taxonSystem].empty?
                     @NameSpace.issueWarning(431, nil)
                  end

                  # taxonomic system (idref) - identification reference [] {citation}
                  hTaxonomy[:idReferences].each do |hCitation|
                     unless hCitation.empty?
                        @xml.tag!('idref') do
                           citationClass.writeXML(hCitation, [])
                        end
                     end
                  end

                  # taxonomic system (ider) - observer
                  # <- hTaxonomy[:observers] role = 'observer'
                  haveObserver = false
                  aRParties = hTaxonomy[:observers]
                  aObservers = @NameSpace.find_responsibility(aRParties, 'observer')
                  aObservers.each do |contactId|
                     hContact = @NameSpace.get_contact(contactId)
                     unless hContact.empty?
                        @xml.tag!('ider') do
                           contactClass.writeXML(hContact)
                           haveObserver = true
                        end
                     end
                  end
                  if !haveObserver && @hResponseObj[:writerShowTags]
                     @xml.tag!('ider')
                  end

                  # taxonomic system (taxonpro) - taxonomic procedures (required)
                  unless hTaxonomy[:idProcedure].nil?
                     @xml.tag!('taxonpro', hTaxonomy[:idProcedure])
                  end
                  if hTaxonomy[:idProcedure].nil?
                     @NameSpace.issueWarning(432, 'taxonpro')
                  end

                  # taxonomic system (taxoncom) - taxonomic identification completeness
                  unless hTaxonomy[:idCompleteness].nil?
                     @xml.tag!('taxoncom', hTaxonomy[:idCompleteness])
                  end
                  if hTaxonomy[:idCompleteness].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('taxoncom')
                  end

                  # taxonomic system (vouchers) - taxonomic voucher []
                  hTaxonomy[:vouchers].each do |hVoucher|
                     @xml.tag!('vouchers') do

                        # voucher (specimen) - specimen (required)
                        unless hVoucher[:specimen].nil?
                           @xml.tag!('specimen', hVoucher[:specimen])
                        end
                        if hVoucher[:specimen].nil?
                           @NameSpace.issueWarning(433, 'specimen')
                        end

                        # voucher (repository) - repository (required)
                        # take first party as repository custodian
                        unless hVoucher[:repository].empty?
                           aRParties = hVoucher[:repository][:parties]
                           contactId = aRParties[0][:contactId]
                           hContact = @NameSpace.get_contact(contactId)
                           unless hContact.empty?
                              @xml.tag!('repository') do
                                 contactClass.writeXML(hContact)
                              end
                           end
                           if hContact.empty?
                              @NameSpace.issueWarning(434, nil)
                           end
                        end
                        if hVoucher[:repository].empty?
                           @NameSpace.issueWarning(434, nil)
                        end

                     end
                     if hTaxonomy[:vouchers].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('vouchers')
                     end

                  end

               end # writeXML
            end # TaxonomySystem

         end
      end
   end
end
