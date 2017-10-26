# ISO <<Class>> MD_EllipsoidParameters
# writer
# 19115-2 output for ISO 19115-2 XML

# History:
# 	Stan Smith 2017-10-26 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class MD_EllipsoidParameters

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hEllipsoid)

                  @xml.tag!('gmd:MD_EllipsoidParameters') do

                     # ellipsoid parameters - semi major axis {real}
                     r = hEllipsoid[:semiMajorAxis]
                     unless r.nil?
                        @xml.tag!('gmd:semiMajorAxis') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:semiMajorAxis')
                     end

                     # ellipsoid parameters - axis units
                     s = hEllipsoid[:axisUnits]
                     unless s.nil?
                        @xml.tag!('gmd:axisUnits', s)
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:axisUnits')
                     end

                     # ellipsoid parameters - denominator of flattening ratio {real}
                     r = hEllipsoid[:denominatorOfFlatteningRatio]
                     unless r.nil?
                        @xml.tag!('gmd:denominatorOfFlatteningRatio') do
                           @xml.tag!('gco:real', r.to_s)
                        end
                     end
                     if r.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gmd:denominatorOfFlatteningRatio')
                     end

                  end # gmd:MD_EllipsoidParameters
               end # writeXML
            end # MD_ProjectionParameters class

         end
      end
   end
end
