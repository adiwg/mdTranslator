# MdTranslator - controller for evaluating and directing readers

# History:
# 	Stan Smith 2014-12-11 original script

module ADIWG
    module Mdtranslator
        module Readers

            def self.handleReader(file)
                case $response[:readerRequested]
                    # ADIwg mdJson JSON schema
                    when 'mdJson'

                        require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
                        intObj = ADIWG::Mdtranslator::Readers::MdJson.inspectFile(file)
                        return intObj

                    # reader name not provided or not supported
                    else
                        $response[:readerValidationPass] = false
                        $response[:readerValidationMessages] << 'Reader name is missing or not supported.'
                        return false
                end
            end

            # return path to readers
            def self.path_to_resources
                File.dirname(File.expand_path(__FILE__))
            end

            # return reader readme text
            def self.get_reader_readme(reader)
                readmeText = 'No readme found'
                path = File.join(path_to_resources, reader, 'readme.md')
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
