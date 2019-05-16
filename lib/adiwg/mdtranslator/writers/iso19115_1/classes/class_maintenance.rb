# ISO <<Class>> MD_MaintenanceInformation
# 19115-1

# 	Stan Smith 2019-03-22 original script.

require_relative '../iso19115_1_writer'
require_relative 'class_codelist'
require_relative 'class_responsibility'
require_relative 'class_scope'
require_relative 'class_date'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_MaintenanceInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end

               def writeXML(hMaintenance, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  dateClass = CI_Date.new(@xml, @hResponseObj)
                  partyClass = CI_Responsibility.new(@xml, @hResponseObj)
                  scopeClass = MD_Scope.new(@xml, @hResponseObj)

                  outContext = 'maintenance information'
                  outContext = inContext + ' maintenance information' unless inContext.nil?

                  @xml.tag! 'mmi:MD_MaintenanceInformation' do

                     # maintenance information - frequency code {MD_MaintenanceFrequencyCode} (required)
                     unless hMaintenance[:frequency].nil?
                        @xml.tag!('mmi:maintenanceAndUpdateFrequency') do
                           codelistClass.writeXML('mmi', 'iso_maintenanceFrequency', hMaintenance[:frequency])
                        end
                     end
                     if hMaintenance[:frequency].nil?
                        @NameSpace.issueWarning(220, 'mmi:maintenanceAndUpdateFrequency', inContext)
                     end

                     # maintenance information - maintenance dates [] {CI_Date}
                     aDates = hMaintenance[:dates]
                     aDates.each do |hDate|
                        @xml.tag!('mmi:maintenanceDate') do
                           dateClass.writeXML(hDate)
                        end
                     end
                     if aDates.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mmi:maintenanceDate')
                     end

                     # maintenance information - user defined maintenance frequency {TM_PeriodDuration} - not implemented

                     # maintenance information - maintenance scope [] {MD_ScopeCode}
                     aScopes = hMaintenance[:scopes]
                     aScopes.each do |hScope|
                        @xml.tag!('mmi:maintenanceScope') do
                           scopeClass.writeXML(hScope, outContext)
                        end
                     end
                     if aScopes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mmi:maintenanceScope')
                     end

                     # maintenance information - note []
                     aNotes = hMaintenance[:notes]
                     aNotes.each do |note|
                        @xml.tag!('mmi:maintenanceNote') do
                           @xml.tag!('gco:CharacterString', note)
                        end
                     end
                     if aNotes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mmi:maintenanceNote')
                     end

                     # maintenance information - contact [{CI_ResponsibleParty}]
                     aParties = hMaintenance[:contacts]
                     aParties.each do |hParty|
                        @xml.tag!('mmi:contact') do
                           partyClass.writeXML(hParty, outContext)
                        end
                     end
                     if aParties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('mmi:contact')
                     end

                  end # gmd:MD_MaintenanceInformation tag
               end # writeXML
            end # MD_MaintenanceInformation class

         end
      end
   end
end
