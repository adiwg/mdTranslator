# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleWriter to use :writerName

module ADIWG
    module Mdtranslator
        module Writers

            def self.handleWriter(intObj)

                # use writer name to load and initiate writer
                # build directory path name for reader
                writerDir = File.join(path_to_resources, $response[:writerName])
                if File.directory?(writerDir)

                    # if directory path exists, build writer file name and require it
                    writerFile = File.join(writerDir, $response[:writerName] + '_writer')
                    require writerFile

                    # build initial class name for writer
                    # ... class name must begin with upper case
                    writerUpCase = $response[:writerName][0].upcase + $response[:writerName][1..-1]
                    writerClass = $WriterNS.const_get(writerUpCase).new

                    # pass internal object to requested writer
                    $response[:writerOutput] = writerClass.writeXML(intObj)
                    return $response
                else
                    # directory path was not found
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

