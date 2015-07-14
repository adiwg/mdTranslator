# MdTranslator - controller for evaluating and directing readers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleReader to use :readerRequested
#   Stan Smith 2015-03-04 changed method of setting $WriterNS
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

module ADIWG
    module Mdtranslator
        module Readers

            def self.handleReader(file, responseObj)

                # use readerRequested from responseObj to build directory path to reader
                # the readers's high level folder must be under the 'writers' directory
                readerDir = File.join(path_to_readers, responseObj[:readerRequested])
                if File.directory?(readerDir)

                    # if directory path exists,
                    # construct the reader's expected file name and require it
                    readerFile = File.join(readerDir, responseObj[:readerRequested] + '_reader')
                    require readerFile

                    # use the file name to build a constant that will equate to the reader's namespace
                    readerClassName = responseObj[:readerRequested].dup
                    readerClassName[0] = readerClassName[0].upcase
                    $ReaderNS = ADIWG::Mdtranslator::Readers.const_get(readerClassName)

                    # pass file and response object to requested reader
                    # the reader will return the internal object with the metadata content loaded
                    return $ReaderNS.readFile(file, responseObj)

                else
                    # the directory path was not found meaning there is no reader with that name
                    # set the appropriate messages and report the failure
                    responseObj[:readerValidationPass] = false
                    responseObj[:readerValidationMessages] << "Validation Failed - see following message(s):\n"
                    responseObj[:readerValidationMessages] << "Reader '#{responseObj[:readerRequested]}' is not supported."
                    return false

                end

            end

            # return path to readers
            def self.path_to_readers
                File.dirname(File.expand_path(__FILE__))
            end

            # return reader readme text
            def self.get_reader_readme(reader)
                readmeText = 'No readme found'
                path = File.join(path_to_readers, reader, 'readme.md')
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
