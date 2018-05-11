# ISO <<Class>> MD_MaintenanceInformation
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-10 add error and warning messaging
#  Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#  Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#  Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-12-18 added contact
# 	Stan Smith 2013-10-31 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_scopeDescription'
require_relative 'class_gcoDateTime'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_MaintenanceInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hMaintenance, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                  dateTimeClass = GcoDateTime.new(@xml, @hResponseObj)

                  outContext = 'maintenance information'
                  outContext = inContext + ' maintenance information' unless inContext.nil?

                  @xml.tag! 'gmd:MD_MaintenanceInformation' do

                     # maintenance information - frequency code (required)
                     s = hMaintenance[:frequency]
                     unless s.nil?
                        @xml.tag!('gmd:maintenanceAndUpdateFrequency') do
                           codelistClass.writeXML('gmd', 'iso_maintenanceFrequency', s)
                        end
                     end
                     if s.nil?
                        @NameSpace.issueWarning(220, 'gmd:maintenanceAndUpdateFrequency', inContext)
                     end

                     # maintenance information - date of next update
                     found = false
                     aDates = hMaintenance[:dates]
                     aDates.each do |hDate|
                        if hDate[:dateType] == 'nextUpdate'
                           found = true
                           @xml.tag!('gmd:dateOfNextUpdate') do
                              dateTimeClass.writeXML(hDate)
                           end
                        end
                     end
                     if !found && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:dateOfNextUpdate')
                     end

                     # maintenance information - user defined maintenance frequency (not supported)

                     # maintenance information - update scope [{MD_ScopeCode}]
                     haveScope = false
                     aScopes = hMaintenance[:scopes]
                     aScopes.each do |hScope|
                        s = hScope[:scopeCode]
                        haveScope = true
                        @xml.tag!('gmd:updateScope') do
                           codelistClass.writeXML('gmd', 'iso_scope', s)
                        end
                     end
                     if !haveScope && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:updateScope')
                     end

                     # maintenance information - update scope description [] (dropped)
                     # according to XSD content type is 'element only' - so tag only, no text within
                     # allowed tags are [featureInstances, attributes, features, other, attributeInstances, dataset]
                     # not collecting this info in mdJson
                     # this field was dropped in 19115-1

                     # maintenance information - note []
                     aNotes = hMaintenance[:notes]
                     aNotes.each do |note|
                        @xml.tag!('gmd:maintenanceNote') do
                           @xml.tag!('gco:CharacterString', note)
                        end
                     end
                     if aNotes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:maintenanceNote')
                     end

                     # maintenance information - contact [{CI_ResponsibleParty}]
                     aParties = hMaintenance[:contacts]
                     aParties.each do |hRParty|
                        role = hRParty[:roleName]
                        aParties = hRParty[:parties]
                        aParties.each do |hParty|
                           @xml.tag!('gmd:contact') do
                              partyClass.writeXML(role, hParty, outContext)
                           end
                        end
                     end
                     if aParties.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:contact')
                     end

                  end # gmd:MD_MaintenanceInformation tag
               end # writeXML
            end # MD_MaintenanceInformation class

         end
      end
   end
end
