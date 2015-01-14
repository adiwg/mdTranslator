# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleWriter to use :writerName

module ADIWG
    module Mdtranslator
        module Writers

            def self.handleWriter(intObj)

                # use writer name to load and initiate requested writer
                # build directory path for writer from writerName
                writerDir = File.join(path_to_resources, $response[:writerName])
                if File.directory?(writerDir)

                    # if directory path exists, build writer file name and then require it
                    writerFile = File.join(writerDir, $response[:writerName] + '_writer')
                    require writerFile

                    # build class name for writer from writerName
                    # ... class name must begin with upper case
                    # ... (1) writer file name must be writerName_writer.rb
                    # ... (2) writer class name must be capitalized writerName
                    # ... (3) $WriterNS is the writer namespace constant set in
                    # ... writerName_writer.rb and initialized when the file is required
                    writerUpCase = $response[:writerName][0].upcase + $response[:writerName][1..-1]
                    writerClass = $WriterNS.const_get(writerUpCase).new

                    # pass internal object to requested writer
                    $response[:writerOutput] = writerClass.writeXML(intObj)
                    return $response
                else
                    # directory path was not found
                    $response[:writerValidationPass] = false
                    $response[:readerValidationMessages] << "Writer name '#{$response[:writerName]}' is not supported."
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

