# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-16 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class VerticalDatum

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aSpaceRefs)

                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        if hSpaceRef[:systemParameterSet][:verticalDatum]
                           hVDatum = hSpaceRef[:systemParameterSet][:verticalDatum]

                           # determine if vertical datum is altitude or depth
                           if hVDatum[:isDepthSystem]
                              @xml.tag!('depthsys') do

                                 # vertical datum 4.2.1.1 (depthdn) - depth datum name (required)
                                 unless hVDatum[:datumName].nil?
                                    @xml.tag!('depthdn', hVDatum[:datumName])
                                 end
                                 if hVDatum[:datumName].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Depth Datum is missing datum name'
                                 end

                                 # vertical datum 4.2.1.2 (depthres) - depth units resolution (required)
                                 unless hVDatum[:verticalResolution].nil?
                                    @xml.tag!('depthres', hVDatum[:verticalResolution])
                                 end
                                 if hVDatum[:verticalResolution].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Depth Datum is missing depth units resolution'
                                 end

                                 # vertical datum 4.2.1.3 (depthdu) - depth units (required)
                                 unless hVDatum[:unitOfMeasure].nil?
                                    @xml.tag!('depthdu', hVDatum[:unitOfMeasure])
                                 end
                                 if hVDatum[:unitOfMeasure].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Depth Datum is missing depth units'
                                 end

                                 # vertical datum 4.2.1.4 (depthem) - depth units (required)
                                 unless hVDatum[:encodingMethod].nil?
                                    @xml.tag!('depthem', hVDatum[:encodingMethod])
                                 end
                                 if hVDatum[:encodingMethod].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Depth Datum is missing depth encoding method'
                                 end

                              end

                           else
                              @xml.tag!('altsys') do

                                 # altitude datum 4.2.2.1 (altdatum) - altitude datum name (required)
                                 unless hVDatum[:datumName].nil?
                                    @xml.tag!('altdatum', hVDatum[:datumName])
                                 end
                                 if hVDatum[:datumName].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Altitude Datum is missing datum name'
                                 end

                                 # altitude datum 4.2.2.2 (altres) - altitude units resolution (required)
                                 unless hVDatum[:verticalResolution].nil?
                                    @xml.tag!('altres', hVDatum[:verticalResolution])
                                 end
                                 if hVDatum[:verticalResolution].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Altitude Datum is missing depth units resolution'
                                 end

                                 # altitude datum 4.2.2.3 (altunits) - altitude units (required)
                                 unless hVDatum[:unitOfMeasure].nil?
                                    @xml.tag!('altunits', hVDatum[:unitOfMeasure])
                                 end
                                 if hVDatum[:unitOfMeasure].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Altitude Datum is missing depth units'
                                 end

                                 # altitude datum 4.2.2.4 (altenc) - altitude units (required)
                                 unless hVDatum[:encodingMethod].nil?
                                    @xml.tag!('altenc', hVDatum[:encodingMethod])
                                 end
                                 if hVDatum[:encodingMethod].nil?
                                    @hResponseObj[:writerPass] = false
                                    @hResponseObj[:writerMessages] << 'Vertical Altitude Datum is missing depth encoding method'
                                 end

                              end
                           end

                        end
                     end
                  end

               end # writeXML
            end # VerticalDatum

         end
      end
   end
end
