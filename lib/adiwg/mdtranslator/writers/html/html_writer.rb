# Writer - html metadata writer

# History:
# 	Stan Smith 2015-01-28 original script

require 'builder'
require 'liquid'
require 'kramdown'
require 'adiwg/mdtranslator/writers/html/md_html_writer'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                def self.startWriter(intObj)

                    # set the format of the output file based on the writer specified
                    $response[:writerFormat] = 'html'
                    $response[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # create new HTML document
                    html = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = $WriterNS::MdHtmlWriter.new(html)
                    metadata = metadataWriter.writeHtml(intObj)

                    # set writer pass to true if no messages
                    # false or warning will be set by code that places the message
                    if $response[:writerMessages].length == 0
                        $response[:writerPass] = true
                    end

                    return metadata
                end

            end
        end
    end
end

