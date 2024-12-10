require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module DownloadURL

               def self.build(option)
                  option[:olResURI] unless option[:olResURI].end_with?('.html')
                end                

            end
         end
      end
   end
end
