# Writer - internal data structure to ISO 19110:2003

# History:
# 	Stan Smith 2014-12-01 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../iso/units'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../iso/codelists'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../iso/classes'))

require 'builder'
require 'date'
require 'uuidtools'
require 'adiwg/mdtranslator/writers/iso19110/class_FCfeatureCatalogue'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                # set writer namespace
                $WriterNS = ADIWG::Mdtranslator::Writers::Iso

                class Iso19110

                    def initialize
                        # reset ISO id='' counter
                        $idCount = '_000'
                    end

                    def writeXML(intObj)

                        # set the format of the output file based on the writer specified
                        $response[:writerFormat] = 'xml'

                        # create new XML document
                        xml = Builder::XmlMarkup.new(indent: 3)
                        metadataWriter = FC_FeatureCatalogue.new(xml)
                        metadata = metadataWriter.writeXML(intObj)

                        # set writer pass to true if no messages
                        # false or warning will be set by code that places the message
                        if $response[:writerMessages].length == 0
                            $response[:writerPass] = true
                        end

                        return metadata
                    end

                end

            end
        end
    end
end

