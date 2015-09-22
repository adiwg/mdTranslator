# ISO <<Class>> MD_DigitalTransferOptions
# writer output in XML

# History:
# 	Stan Smith 2013-09-26 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-09-21 added transfer size

require_relative 'class_onlineResource'
require_relative 'class_medium'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_DigitalTransferOptions

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(transOption)

                        # classes used
                        olResClass =  CI_OnlineResource.new(@xml, @responseObj)
                        medClass =  MD_Medium.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_DigitalTransferOptions') do

                            # digital transfer options - transfer size / units
                            s = transOption[:transferSize]
                            if !s.nil?
                                su = transOption[:transferSizeUnits].upcase
                                if !su.nil?
                                    case su
                                        when 'KB'
                                            s = s * 0.001
                                        when 'GB'
                                            s = s * 1000.0
                                        when 'TB'
                                            s = s * 1000000.0
                                        else
                                            # MB assumed otherwise
                                    end
                                end
                                @xml.tag!('gmd:transferSize') do
                                    @xml.tag!('gco:Real', s.to_s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:transferSize')
                            end

                            # digital transfer options - online [] - CI_OnlineResource
                            aOnTranOpts = transOption[:online]
                            if !aOnTranOpts.empty?
                                aOnTranOpts.each do |olTranOpt|
                                    @xml.tag!('gmd:onLine') do
                                        olResClass.writeXML(olTranOpt)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:onLine')
                            end

                            # digital transfer options - offline - MD_Medium
                            hOffTranOpt = transOption[:offline]
                            if !hOffTranOpt.empty?
                                @xml.tag!('gmd:offLine') do
                                    medClass.writeXML(hOffTranOpt)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gmd:offLine')
                            end

                        end

                    end

                end

            end
        end
    end
end
