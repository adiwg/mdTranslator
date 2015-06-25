# Writer - html metadata writer

# History:
# 	Stan Smith 2015-01-28 original script
#   Stan Smith 2015-06-23 replace global ($response) with passed in object (responseObj)

require 'builder'
require 'adiwg/mdtranslator/writers/html/md_html_writer'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                def self.startWriter(intObj, responseObj)

                    # set the format of the output file based on the writer specified
                    responseObj[:writerFormat] = 'html'
                    responseObj[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # create new HTML document
                    html = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = $WriterNS::MdHtmlWriter.new(html, intObj)
                    metadata = metadataWriter.writeHtml()

                    # set writer pass to true if no messages
                    # false or warning will be set by code that places the message
                    if responseObj[:writerMessages].length == 0
                        responseObj[:writerPass] = true
                    end

                    return metadata
                end

            end
        end
    end
end

