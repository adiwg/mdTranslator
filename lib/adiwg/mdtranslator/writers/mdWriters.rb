# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script

module ADIWG
    module Mdtranslator
        module Writers

            def self.handleWriter(intObj)
                case $response[:writerName]

                    # ISO 19110 standard for feature catalogue used to describe tabular data dictionaries
                    when 'iso19110'
                        require 'adiwg/mdtranslator/writers/iso19110/iso19110_writer'
                        writerClass = ADIWG::Mdtranslator::Writers::Iso::Iso19110.new

                        # initiate the writer
                        $response[:writerOutput] = writerClass.writeXML(intObj)
                        return $response


                    # ISO 19115-2:2009 standard for geospatial metadata
                    when 'iso19115_2'
                        require 'adiwg/mdtranslator/writers/iso19115_2/iso19115_2_writer'
                        writerClass = ADIWG::Mdtranslator::Writers::Iso::Iso191152.new

                        # initiate the writer
                        $response[:writerOutput] = writerClass.writeXML(intObj)
                        return $response

                    # writer name not provided or not supported
                    else
                        $response[:writerValidationPass] = false
                        $response[:readerValidationMessages] << "Writer name '#{$response[:writerName]}' is missing or not supported."
                        return false

                end

            end

            # return path to writers
            def self.path_to_resources
                File.dirname(File.expand_path(__FILE__))
            end

            # return writer readme text
            def self.get_writer_readme(writer)
                readmeText = 'No readme found'
                path = File.join(path_to_resources, writer, 'readme.md')
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

