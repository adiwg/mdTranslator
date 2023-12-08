# ISO <<Class>> MD_GeometricObjects
# 19115-2 writer output in XML

# History:
# 	Stan Smith 2019-04-16 original script.

require_relative '../iso19115_3_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_3

            class MD_GeometricObjects

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_3
               end

               def writeXML(hGeoObj, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  outContext = 'geometric object'
                  outContext = inContext + ' geometric object' unless inContext.nil?

                  @xml.tag!('msr:MD_GeometricObjects') do

                     # geometric object - object type (required)
                     unless hGeoObj[:objectType].nil?
                        @xml.tag!('msr:geometricObjectType') do
                           codelistClass.writeXML('msr', 'iso_geometricObjectType', hGeoObj[:objectType])
                        end
                     end
                     if hGeoObj[:objectType].nil?
                        @NameSpace.issueWarning(150, 'msr:geometricObjectType', outContext)
                     end

                     # geometric object - object count
                     unless hGeoObj[:objectCount].nil?
                        @xml.tag!('msr:geometricObjectCount') do
                           @xml.tag!('gco:Integer', hGeoObj[:objectCount].to_s)
                        end
                     end
                     if hGeoObj[:objectCount].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('msr:geometricObjectCount')
                     end

                  end # msr:MD_GeometricObjects tag
               end # writeXML
            end # MD_GeometricObjects class

         end
      end
   end
end
