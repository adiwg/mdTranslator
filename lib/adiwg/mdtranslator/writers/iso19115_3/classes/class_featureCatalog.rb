# ISO <<abstract class>> MD_FeatureCatalogue
# 19115-3 writer output in XML

# History:
# 	Stan Smith 2019-08-20 original script.

require_relative '../../iso19110/iso19110_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_FeatureCatalogue

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end
               
               def writeXML(intObj,whichDict)

                  # set up iso19110 writer namespace
                  nameSpace19110 = ADIWG::Mdtranslator::Writers::Iso19110

                  # write 19110 record
                  fcCatalogClass = nameSpace19110.startWriter(intObj, @hResponseObj, whichDict, true)

                  # strip first line
                  first_line = fcCatalogClass.index("\n")
                  fcCatalogClass.slice!(0, first_line + 1)

                  outContext = 'feature catalog'

                  unless fcCatalogClass.empty?
                     @xml.tag!('mrc:MD_FeatureCatalogue') do
                        @xml.tag!('mrc:featureCatalogue') do

                           # data dictionary
                           @xml << fcCatalogClass

                        end
                     end
                  end

               end # writeXML
            end # MD_FeatureCatalogue class

         end
      end
   end
end
