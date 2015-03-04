# MdTranslator - controller for evaluating and directing readers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleReader to use :readerRequested

module ADIWG
    module Mdtranslator
        module Readers

            def self.handleReader(file)

                # use reader name to load and initiate reader
                # build directory path name for reader
                readerDir = File.join(path_to_resources, $response[:readerRequested])
                if File.directory?(readerDir)

                    # if directory path exists, build reader file name and require it
                    readerFile = File.join(readerDir, $response[:readerRequested] + '_reader')
                    require readerFile

                    # pass file to requested reader and return internal object
                    # $ReaderNS is the reader namespace constant set in
                    # ... readerRequested_reader.rb and initialized when the file is required
                    return $ReaderNS.readFile(file)
                else
                    # directory path was not found
                    $response[:readerValidationPass] = false
                    $response[:readerValidationMessages] << "Reader name '#{$response[:readerRequested]}' is not supported."
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
