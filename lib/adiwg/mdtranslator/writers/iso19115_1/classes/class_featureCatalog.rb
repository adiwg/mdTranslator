# ISO <<abstract class>> MD_FeatureCatalogue
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-08-20 original script. 

require_relative '../../iso19110/classes/class_fcFeatureCatalogue'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_FeatureCatalogue

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_1
               end
               
               def writeXML(intObj,whichDict)

                  # set up iso19110 writer namespace
                  nameSpace19110 = ADIWG::Mdtranslator::Writers::Iso19110

                  # write 19110 record
                  fcCatalogClass = nameSpace19110.startWriter(intObj, @hResponseObj, whichDict)

                  # strip first line
                  fcArray = fcCatalogClass.split("\n")[1..-1].join

                  outContext = 'feature catalog'

                  unless fcCatalogClass.empty?
                     @xml.tag!('mrc:MD_FeatureCatalogue') do
                        @xml.tag!('mrc:featureCatalogue') do

                           # data dictionary
                           @xml << fcArray

                        end
                     end
                  end

               end # writeXML
            end # MD_FeatureCatalogue class

         end
      end
   end
end
