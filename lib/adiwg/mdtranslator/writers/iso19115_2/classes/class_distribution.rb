# ISO <<Class>> MD_Distribution
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

require_relative 'class_distributor'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MD_Distribution

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(aDistributors)

                        # classes used
                        distributorClass = MD_Distributor.new(@xml, @responseObj)

                        @xml.tag!('gmd:MD_Distribution') do

                            # distribution - distributor - required
                            unless aDistributors.empty?
                                aDistributors.each do |hDistributor|
                                    @xml.tag!('gmd:distributor') do
                                        distributorClass.writeXML(hDistributor)
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
