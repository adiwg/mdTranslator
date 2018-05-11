# ISO <<Class>> MD_GeometricObjects
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
# 	Stan Smith 2016-12-08 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_GeometricObjects

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end

               def writeXML(hGeoObj)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                  @xml.tag!('gmd:MD_GeometricObjects') do

                     # geometric object - object type (required)
                     s = hGeoObj[:objectType]
                     if s.nil?
                        @NameSpace.issueWarning(150, 'gmd:geometricObjectType', 'spatial representation')
                     else
                        @xml.tag!('gmd:geometricObjectType') do
                           codelistClass.writeXML('gmd', 'iso_geometricObjectType', s)
                        end
                     end

                     # geometric object - object count
                     s = hGeoObj[:objectCount]
                     unless s.nil?
                        @xml.tag!('gmd:geometricObjectCount') do
                           @xml.tag!('gco:Integer', s.to_s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:geometricObjectCount')
                     end

                  end # gmd:MD_GeometricObjects tag
               end # writeXML
            end # MD_GeometricObjects class

         end
      end
   end
end
