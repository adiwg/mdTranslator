# Writer - internal data structure to ISO 19110:2003

# History:
# 	Stan Smith 2014-12-01 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-03-02 added test and return for missing data dictionary

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
            module Iso19110

                def self.startWriter(intObj)

                    # reset ISO id='' counter
                    $idCount = '_000'

                    # set the format of the output file based on the writer specified
                    $response[:writerFormat] = 'xml'
                    $response[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # test for a valid dataDictionary object in the internal object
                    aDictionaries = intObj[:dataDictionary]
                    if aDictionaries.length == 0
                        $response[:writerMessages] << 'Writer Failed - see following message(s):\n'
                        $response[:writerMessages] << 'No data dictionary was loaded from the input file'
                        $response[:writerPass] = false
                        return
                    end

                    # create new XML document
                    xml = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = $WriterNS::FC_FeatureCatalogue.new(xml)
                    metadata = metadataWriter.writeXML(intObj)

                    # set writer pass to true if no writer modules set it to false
                    # false or warning will be set by code that places the message
                    # load metadata into $response
                    if $response[:writerPass].nil?
                        $response[:writerPass] = true
                    end

                    return metadata
                end

            end
        end
    end
end

