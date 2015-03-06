# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleWriter to use :writerName
#   Stan Smith 2015-03-04 changed method of setting $WriterNS

module ADIWG
    module Mdtranslator
        module Writers

            def self.handleWriter(intObj)

                # this is a temp fix until the directory structure is changed
                if $response[:writerName] == 'iso'
                    $response[:writerPass] = false
                    $response[:writerMessages] << 'Writer not called - see following message(s):\n'
                    $response[:writerMessages] << "Writer name 'iso' is not supported."
                    return false
                end

                # use writer name to load and initiate requested writer
                # build directory path for writer from writerName
                writerDir = File.join(path_to_resources, $response[:writerName])
                if File.directory?(writerDir)

                    # if directory path exists, build writer file name and then require it
                    writerFile = File.join(writerDir, $response[:writerName] + '_writer')
                    require writerFile
                    writerClassName = $response[:writerName].dup
                    writerClassName[0] = writerClassName[0].upcase
                    $WriterNS = ADIWG::Mdtranslator::Writers.const_get(writerClassName)

                    # pass internal object to requested writer
                    $response[:writerOutput] = $WriterNS.startWriter(intObj)

                else
                    # directory path was not found
                    $response[:writerPass] = false
                    $response[:writerMessages] << 'Writer not called - see following message(s):\n'
                    $response[:writerMessages] << "Writer name '#{$response[:writerName]}' is not supported."
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

