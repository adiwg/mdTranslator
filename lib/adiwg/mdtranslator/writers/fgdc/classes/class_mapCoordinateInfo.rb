# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-12 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class CoordinateInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(aRepTypes, aResolutions)

                  haveCInfo = false
                  haveCInfo = true unless aRepTypes.empty?
                  aResolutions.each do |hResolution|
                     haveCInfo = true if hResolution[:coordinateResolution]
                     haveCInfo = true if hResolution[:bearingDistanceResolution]
                  end
                  unitOfMeasure = nil

                  # coordinate information 4.1.2.4 (planci) - planar coordinate information
                  if haveCInfo
                     @xml.tag!('planar') do
                        @xml.tag!('planci') do

                           # coordinate information 4.1.2.4.1 (plance) - planar coordinate encoding method (required)
                           # <- spatialRepresentationTypes[].first
                           unless aRepTypes.empty?
                              @xml.tag!('plance', aRepTypes[0])
                           end
                           if aRepTypes.empty?
                              @hResponseObj[:writerPass] = false
                              @hResponseObj[:writerMessages] << 'Planar Coordinate Information is missing encoding method'
                           end

                           # <- spatialResolutions[] look for coordinateResolution and bearingDistanceResolution
                           # take first encountered, only one is permitted from file
                           aResolutions.each do |hResolution|
                              unless hResolution[:coordinateResolution].empty?
                                 hCoordRes = hResolution[:coordinateResolution]

                                 # coordinate information 4.1.2.4.2 (coordrep) - coordinate representation
                                 @xml.tag!('coordrep') do

                                    # coordinate information 4.1.2.4.2.1 (absres) - abscissa resolution (required)
                                    unless hCoordRes[:abscissaResolutionX].nil?
                                       @xml.tag!('absres', hCoordRes[:abscissaResolutionX].to_f)
                                    end
                                    if hCoordRes[:abscissaResolutionX].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Coordinate Representation is missing abscissa resolution'
                                    end

                                    # coordinate information 4.1.2.4.2.2 (ordres) - ordinate resolution (required)
                                    unless hCoordRes[:ordinateResolutionY].nil?
                                       @xml.tag!('ordres', hCoordRes[:ordinateResolutionY].to_f)
                                    end
                                    if hCoordRes[:ordinateResolutionY].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Coordinate Representation is missing ordinate resolution'
                                    end

                                    # coordinate information 4.1.2.4.4 (plandu) - distance unit of measure (required)
                                    unless hCoordRes[:unitOfMeasure].nil?
                                       unitOfMeasure = hCoordRes[:unitOfMeasure]
                                    end
                                    if hCoordRes[:unitOfMeasure].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing planar distance units'
                                    end

                                 end
                                 break
                              end

                              unless hResolution[:bearingDistanceResolution].empty?
                                 hBearRes = hResolution[:bearingDistanceResolution]

                                 # coordinate information 4.1.2.4.3 (distbrep) - bearing and distance representation
                                 @xml.tag!('distbrep') do

                                    # coordinate information 4.1.2.4.3.1 (distres) - distance resolution (required)
                                    unless hBearRes[:distanceResolution].nil?
                                       @xml.tag!('distres', hBearRes[:distanceResolution].to_f)
                                    end
                                    if hBearRes[:distanceResolution].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing distance resolution'
                                    end

                                    # coordinate information 4.1.2.4.3.2 (bearres) - bearing resolution (required)
                                    unless hBearRes[:bearingResolution].nil?
                                       @xml.tag!('bearres', hBearRes[:bearingResolution])
                                    end
                                    if hBearRes[:bearingResolution].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing bearing resolution'
                                    end

                                    # coordinate information 4.1.2.4.3.3 (bearunit) - bearing units of measure (required)
                                    unless hBearRes[:bearingUnitOfMeasure].nil?
                                       @xml.tag!('bearunit', hBearRes[:bearingUnitOfMeasure])
                                    end
                                    if hBearRes[:bearingUnitOfMeasure].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing bearing units'
                                    end

                                    # coordinate information 4.1.2.4.3.4 (bearrefd) - bearing units of measure (required)
                                    unless hBearRes[:bearingReferenceDirection].nil?
                                       @xml.tag!('bearrefd', hBearRes[:bearingReferenceDirection])
                                    end
                                    if hBearRes[:bearingReferenceDirection].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing bearing reference direction'
                                    end

                                    # coordinate information 4.1.2.4.3.5 (bearrefm) - bearing reference meridian (required)
                                    unless hBearRes[:bearingReferenceMeridian].nil?
                                       @xml.tag!('bearrefm', hBearRes[:bearingReferenceMeridian])
                                    end
                                    if hBearRes[:bearingReferenceMeridian].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing bearing reference meridian'
                                    end

                                    # coordinate information 4.1.2.4.4 (plandu) - distance unit of measure (required)
                                    unless hBearRes[:distanceUnitOfMeasure].nil?
                                       unitOfMeasure = hBearRes[:distanceUnitOfMeasure]
                                    end
                                    if hBearRes[:distanceUnitOfMeasure].nil?
                                       @hResponseObj[:writerPass] = false
                                       @hResponseObj[:writerMessages] << 'Bearing-Distance Representation is missing planar distance units'
                                    end

                                 end
                                 break

                              end
                           end

                           # planar distance units 4.1.2.4.4 (plandu) - (required)
                           # value and error messages handled in above code
                           # just write it out here
                           unless unitOfMeasure.nil?
                              @xml.tag!('plandu', unitOfMeasure)
                           end

                        end
                     end
                  end

               end # writeXML
            end # CoordinateInformation

         end
      end
   end
end
