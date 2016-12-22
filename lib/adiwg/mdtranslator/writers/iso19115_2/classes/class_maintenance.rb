# ISO <<Class>> MD_MaintenanceInformation
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-12 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (hResponseObj)
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-12-18 added contact
# 	Stan Smith 2013-10-31 original script.

require_relative 'class_codelist'
require_relative 'class_responsibleParty'
require_relative 'class_scopeDescription'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_MaintenanceInformation

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hMaintenance)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                        partyClass = CI_ResponsibleParty.new(@xml, @hResponseObj)
                        scopeClass = MD_ScopeDescription.new(@xml, @hResponseObj)

                        @xml.tag! 'gmd:MD_MaintenanceInformation' do

                            # maintenance information - frequency code (required)
                            s = hMaintenance[:frequency]
                            unless s.nil?
                                @xml.tag!('gmd:maintenanceAndUpdateFrequency') do
                                    codelistClass.writeXML('gmd', 'iso_maintenanceFrequency',s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:maintenanceAndUpdateFrequency', {'gco:nilReason' => 'unknown'})
                            end

                            # maintenance information - date of next update (not supported)
                            # maintenance information - user defined maintenance frequency (not supported)

                            # maintenance information - update scope [{MD_ScopeCode}]
                            haveScope = false
                            aScopes = hMaintenance[:scopes]
                            aScopes.each do |hScope|
                                s = hScope[:scopeCode]
                                haveScope = true
                                @xml.tag!('gmd:updateScope') do
                                    codelistClass.writeXML('gmd', 'iso_scope',s)
                                end
                            end
                            if !haveScope && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:updateScope')
                            end

                            # maintenance information - update scope description
                            haveDescription = false
                            aScopes.each do |hResScope|
                                aScopeDes = hResScope[:scopeDescription]
                                aScopeDes.each do |hScopeDes|
                                    haveDescription = true
                                    @xml.tag!('gmd:updateScopeDescription') do
                                        scopeClass.writeXML(hScopeDes)
                                    end
                                end
                            end
                            if !haveDescription && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:updateScopeDescription')
                            end

                            # maintenance information - note
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
                                aParties = hRParty[:party]
                                aParties.each do |hParty|
                                    @xml.tag!('gmd:contact') do
                                        partyClass.writeXML(role, hParty)
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
