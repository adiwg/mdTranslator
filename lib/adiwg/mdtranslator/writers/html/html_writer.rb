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

                # set writer namespace
                $WriterNS = ADIWG::Mdtranslator::Writers::Html

                def self.stringify_keys(hIn)
                    hOut = Hash[hIn.map{|(k,v) | [k.to_s,v]}]
                    hOut.each do |key, value|
                        if value.class == Hash
                            hOut[key] = stringify_keys(value)
                        elsif value.class == Array
                            if value[0].class == Hash
                                aTemp = Array.new()
                                value.each do |item|
                                    aTemp << stringify_keys(item)
                                end
                                hOut[key] = aTemp
                            end
                        end
                    end
                end

                def self.startWriter(intObj)

                    # convert the internal object from variable named hash
                    # to string named hash to be compatible with liquid
                    intObjStrings = stringify_keys(intObj)

                    # set the format of the output file based on the writer specified
                    $response[:writerFormat] = 'html'
                    $response[:writerVersion] = ADIWG::Mdtranslator::VERSION

                    # create new HTML document
                    html = Builder::XmlMarkup.new(indent: 3)
                    metadataWriter = $WriterNS::MdHtmlWriter.new(html)
                    metadata = metadataWriter.writeHtml(intObjStrings)
                    puts metadata

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

