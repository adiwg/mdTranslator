# ISO <<Class>> MD_Distribution
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_distributor'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_Distribution

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(aDistributors)

                        # classes used
                        distributorClass = $IsoNS::MD_Distributor.new(@xml)

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
