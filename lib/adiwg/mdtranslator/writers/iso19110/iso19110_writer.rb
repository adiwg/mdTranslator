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
require 'class_FCfeatureCatalogue'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19110

                class Iso19110Writer

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

                # return path to readers and writers
                def self.path_to_resources
                    File.join(File.dirname(File.expand_path(__FILE__)), 'mdtranslator')
                end

                # return writer readme text
                def self.get_writer_readme(writer)
                    readmeText = 'No text found'
                    path = File.join(path_to_resources, 'writers', writer, 'readme.md')
                    if File.exist?(path)
                        file = File.open(path, 'r')
                        readmeText = file.read
                        file.close
                    end
                    return readmeText
                end

            end
        end
    end
end

