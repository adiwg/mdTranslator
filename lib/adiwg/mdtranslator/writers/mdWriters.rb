# MdTranslator - controller for evaluating and directing writers

# History:
# 	Stan Smith 2014-12-11 original script
#   Stan Smith 2012-12-16 generalized handleWriter to use :writerName
#   Stan Smith 2015-03-04 changed method of setting $WriterNS
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS

module ADIWG
    module Mdtranslator
        module Writers

            def self.handleWriter(intObj, responseObj, paramsObj)

                # use writerName from responseObj to build directory path to writer
                # the writer's high level folder must be under the 'writers' directory
                writerDir = File.join(path_to_writers, responseObj[:writerName])
                if File.directory?(writerDir)

                    # if directory path exists, build writer file name and require it
                    writerFile = File.join(writerDir, responseObj[:writerName] + '_writer')
                    require writerFile

                    # build the namespace for the writer
                    writerNS = responseObj[:writerName].dup
                    writerNS[0] = writerNS[0].upcase

                    # pass internal object and response object to the writer
                    responseObj[:writerOutput] = ADIWG::Mdtranslator::Writers.const_get(writerNS).startWriter(intObj, responseObj, paramsObj)

                else
                    # directory path was not found
                    responseObj[:writerPass] = false
                    responseObj[:writerMessages] << 'Writer not called - see following message(s):\n'
                    responseObj[:writerMessages] << "Writer name '#{responseObj[:writerName]}' is not supported."
                    return false
                end

            end

            # return path to writers
            def self.path_to_writers
                File.dirname(File.expand_path(__FILE__))
            end

            # return writer readme text
            # this is called from the Rails API
            def self.get_writer_readme(writer)
                readmeText = 'No readme found'
                path = File.join(path_to_writers, writer, 'readme.md')
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

