# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-20 refactored error and warning messaging
#  Stan Smith 2018-01-12 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class PlanarInformation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aRepTypes, aResolutions)

                  # <- spatialReferencesTypes[] (encoding method) 4.1.2.4.1
                  # <- spatialResolution[].coordinateResolution (coordinate representation) 4.1.2.4.2
                  # <- spatialResolution[].bearingDistanceResolution (bearing-distance representation) 4.1.2.4.3
                  # <- spatialResolution[] (distance units) 4.1.2.4.4

                  haveCInfo = false
                  haveCInfo = true unless aRepTypes.empty?
                  aResolutions.each do |hResolution|
                     haveCInfo = true if hResolution[:coordinateResolution]
                     haveCInfo = true if hResolution[:bearingDistanceResolution]
                  end
                  unitOfMeasure = nil

                  # coordinate information 4.1.2.4 (planci) - planar coordinate information
                  if haveCInfo
                     @xml.tag!('planci') do

                        # coordinate information 4.1.2.4.1 (plance) - planar coordinate encoding method (required)
                        # <- spatialRepresentationTypes[].first
                        unless aRepTypes.empty?
                           @xml.tag!('plance', aRepTypes[0])
                        end
                        if aRepTypes.empty?
                           @NameSpace.issueWarning(260, 'plance')
                        end

                        # <- spatialResolutions[] look for coordinateResolution or bearingDistanceResolution
                        # take first one encountered, only one is permitted in FGDC
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
                                    @NameSpace.issueWarning(261, 'absres')
                                 end

                                 # coordinate information 4.1.2.4.2.2 (ordres) - ordinate resolution (required)
                                 unless hCoordRes[:ordinateResolutionY].nil?
                                    @xml.tag!('ordres', hCoordRes[:ordinateResolutionY].to_f)
                                 end
                                 if hCoordRes[:ordinateResolutionY].nil?
                                    @NameSpace.issueWarning(262, 'ordres')
                                 end

                                 # coordinate information 4.1.2.4.4 (plandu) - distance unit of measure (required)
                                 unless hCoordRes[:unitOfMeasure].nil?
                                    unitOfMeasure = hCoordRes[:unitOfMeasure]
                                 end
                                 if hCoordRes[:unitOfMeasure].nil?
                                    @NameSpace.issueWarning(263, 'plandu')
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
                                    @NameSpace.issueWarning(264, 'distres')
                                 end

                                 # coordinate information 4.1.2.4.3.2 (bearres) - bearing resolution (required)
                                 unless hBearRes[:bearingResolution].nil?
                                    @xml.tag!('bearres', hBearRes[:bearingResolution])
                                 end
                                 if hBearRes[:bearingResolution].nil?
                                    @NameSpace.issueWarning(265, 'bearres')
                                 end

                                 # coordinate information 4.1.2.4.3.3 (bearunit) - bearing units of measure (required)
                                 unless hBearRes[:bearingUnitOfMeasure].nil?
                                    @xml.tag!('bearunit', hBearRes[:bearingUnitOfMeasure])
                                 end
                                 if hBearRes[:bearingUnitOfMeasure].nil?
                                    @NameSpace.issueWarning(266, 'bearunit')
                                 end

                                 # coordinate information 4.1.2.4.3.4 (bearrefd) - bearing units of measure (required)
                                 unless hBearRes[:bearingReferenceDirection].nil?
                                    @xml.tag!('bearrefd', hBearRes[:bearingReferenceDirection])
                                 end
                                 if hBearRes[:bearingReferenceDirection].nil?
                                    @NameSpace.issueWarning(267, 'bearrefd')
                                 end

                                 # coordinate information 4.1.2.4.3.5 (bearrefm) - bearing reference meridian (required)
                                 unless hBearRes[:bearingReferenceMeridian].nil?
                                    @xml.tag!('bearrefm', hBearRes[:bearingReferenceMeridian])
                                 end
                                 if hBearRes[:bearingReferenceMeridian].nil?
                                    @NameSpace.issueWarning(268, 'bearrefm')
                                 end

                                 # coordinate information 4.1.2.4.4 (plandu) - distance unit of measure (required)
                                 unless hBearRes[:distanceUnitOfMeasure].nil?
                                    unitOfMeasure = hBearRes[:distanceUnitOfMeasure]
                                 end
                                 if hBearRes[:distanceUnitOfMeasure].nil?
                                    @NameSpace.issueWarning(269, 'plandu')
                                 end

                              end

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

                  # error message
                  unless haveCInfo
                     @NameSpace.issueWarning(270, nil)
                  end

               end # writeXML
            end # CoordinateInformation

         end
      end
   end
end
