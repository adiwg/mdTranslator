# ISO <<Class>> MD_Distributor
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_responsibleParty'
require_relative 'class_standardOrderProcess'
require_relative 'class_format'
require_relative 'class_digitalTransferOptions'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Distributor

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(distributor)

                        # classes used
                        rPartyClass =  CI_ResponsibleParty.new(@xml, @responseObj)
                        sOrderProcClass =  MD_StandardOrderProcess.new(@xml, @responseObj)
                        rFormatClass =  MD_Format.new(@xml, @responseObj)
                        dTranOptClass =  MD_DigitalTransferOptions.new(@xml, @responseObj)

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
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
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
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:distributorTransferOptions')
                            end


                        end

                    end

                end

            end
        end
    end
end
