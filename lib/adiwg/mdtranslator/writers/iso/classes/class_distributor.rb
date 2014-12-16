# ISO <<Class>> MD_Distributor
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_responsibleParty'
require 'class_standardOrderProcess'
require 'class_format'
require 'class_digitalTransferOptions'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Distributor

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(distributor)

                        # classes used
                        rPartyClass = $WriterNS::CI_ResponsibleParty.new(@xml)
                        sOrderProcClass = $WriterNS::MD_StandardOrderProcess.new(@xml)
                        rFormatClass = $WriterNS::MD_Format.new(@xml)
                        dTranOptClass = $WriterNS::MD_DigitalTransferOptions.new(@xml)

                        @xml.tag!('gmd:MD_Distributor') do

                            # distributor - distributor contact - CI_ResponsibleParty - required
                            hResParty = distributor[:distContact]
                            if hResParty.empty?
                                @xml.tag!('gmd:distributorContact', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:distributorContact') do
                                    rPartyClass.writeXML(hResParty)
                                end
                            end

                            # distributor - distribution order process []
                            aDistOrderProc = distributor[:distOrderProc]
                            if !aDistOrderProc.empty?
                                aDistOrderProc.each do |distOrder|
                                    @xml.tag!('gmd:distributionOrderProcess') do
                                        sOrderProcClass.writeXML(distOrder)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:distributionOrderProcess')
                            end

                            # distributor - distributor format []
                            aDistFormats = distributor[:distFormat]
                            if !aDistFormats.empty?
                                aDistFormats.each do |dFormat|
                                    @xml.tag!('gmd:distributorFormat') do
                                        rFormatClass.writeXML(dFormat)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:distributorFormat')
                            end

                            # distributor - distributor transfer options []
                            aDistTransOpts = distributor[:distTransOption]
                            if !aDistTransOpts.empty?
                                aDistTransOpts.each do |dTransOpt|
                                    @xml.tag!('gmd:distributorTransferOptions') do
                                        dTranOptClass.writeXML(dTransOpt)
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:distributorTransferOptions')
                            end


                        end

                    end

                end

            end
        end
    end
end
