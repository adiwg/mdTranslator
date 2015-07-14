# ISO <<Class>> MD_MaintenanceInformation
# writer output in XML

# History:
# 	Stan Smith 2013-10-31 original script.
# 	Stan Smith 2013-12-18 added contact
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_codelist'
require_relative 'class_responsibleParty'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_MaintenanceInformation

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hMaintInfo)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @responseObj)
                        rPartyClass = CI_ResponsibleParty.new(@xml, @responseObj)

                        @xml.tag! 'gmd:MD_MaintenanceInformation' do

                            # maintenance information - frequency code - required
                            s = hMaintInfo[:maintFreq]
                            if s.nil?
                                @xml.tag!('gmd:maintenanceAndUpdateFrequency', {'gco:nilReason' => 'unknown'})
                            else
                                @xml.tag!('gmd:maintenanceAndUpdateFrequency') do
                                    codelistClass.writeXML('iso_maintenanceFrequency',s)
                                end
                            end

                            # maintenance information - note
                            aNotes = hMaintInfo[:maintNotes]
                            if !aNotes.empty?
                                aNotes.each do |note|
                                    @xml.tag!('gmd:maintenanceNote') do
                                        @xml.tag!('gco:CharacterString', note)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:maintenanceNote')
                            end

                            # maintenance information - contact - CI_ResponsibleParty
                            aContacts = hMaintInfo[:maintContacts]
                            if aContacts.empty? && $showEmpty
                                @xml.tag!('gmd:contact')
                            else
                                aContacts.each do |hContact|
                                    @xml.tag!('gmd:contact') do
                                        rPartyClass.writeXML(hContact)
                                    end
                                end
                            end

                        end

                    end

                end

            end
        end
    end
end
