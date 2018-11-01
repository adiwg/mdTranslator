# FGDC <<Class>> SpatialReference
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-10-31 fix empty verticalDatum issue
#  Stan Smith 2018-09-26 deprecate datumName use datumIdentifier.identifier
#  Stan Smith 2018-03-27 refactored error and warning messaging
#  Stan Smith 2018-01-16 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class VerticalDatum

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(aSpaceRefs, inContext = nil)

                  aSpaceRefs.each do |hSpaceRef|
                     unless hSpaceRef[:systemParameterSet].empty?
                        if hSpaceRef[:systemParameterSet][:verticalDatum]
                           hVDatum = hSpaceRef[:systemParameterSet][:verticalDatum]
                           unless hVDatum.empty?

                              # determine if vertical datum is altitude or depth
                              if hVDatum[:isDepthSystem]
                                 @xml.tag!('depthsys') do

                                    # vertical datum 4.2.1.1 (depthdn) - depth datum name (required)
                                    unless hVDatum[:datumIdentifier].empty?
                                       @xml.tag!('depthdn', hVDatum[:datumIdentifier][:identifier])
                                    end
                                    if hVDatum[:datumIdentifier].empty?
                                       @NameSpace.issueWarning(460, 'depthdn')
                                    end

                                    # vertical datum 4.2.1.2 (depthres) - depth units resolution (required)
                                    unless hVDatum[:verticalResolution].nil?
                                       @xml.tag!('depthres', hVDatum[:verticalResolution])
                                    end
                                    if hVDatum[:verticalResolution].nil?
                                       @NameSpace.issueWarning(461, 'depthres')
                                    end

                                    # vertical datum 4.2.1.3 (depthdu) - depth units (required)
                                    unless hVDatum[:unitOfMeasure].nil?
                                       @xml.tag!('depthdu', hVDatum[:unitOfMeasure])
                                    end
                                    if hVDatum[:unitOfMeasure].nil?
                                       @NameSpace.issueWarning(462, 'depthdu')
                                    end

                                    # vertical datum 4.2.1.4 (depthem) - encoding method (required)
                                    unless hVDatum[:encodingMethod].nil?
                                       @xml.tag!('depthem', hVDatum[:encodingMethod])
                                    end
                                    if hVDatum[:encodingMethod].nil?
                                       @NameSpace.issueWarning(463, 'depthem')
                                    end

                                 end

                              else
                                 @xml.tag!('altsys') do

                                    # altitude datum 4.2.2.1 (altdatum) - altitude datum name (required)
                                    unless hVDatum[:datumIdentifier].empty?
                                       @xml.tag!('altdatum', hVDatum[:datumIdentifier][:identifier])
                                    end
                                    if hVDatum[:datumIdentifier].empty?
                                       @NameSpace.issueWarning(464, 'altdatum')
                                    end

                                    # altitude datum 4.2.2.2 (altres) - altitude units resolution (required)
                                    unless hVDatum[:verticalResolution].nil?
                                       @xml.tag!('altres', hVDatum[:verticalResolution])
                                    end
                                    if hVDatum[:verticalResolution].nil?
                                       @NameSpace.issueWarning(465, 'altres')
                                    end

                                    # altitude datum 4.2.2.3 (altunits) - altitude units (required)
                                    unless hVDatum[:unitOfMeasure].nil?
                                       @xml.tag!('altunits', hVDatum[:unitOfMeasure])
                                    end
                                    if hVDatum[:unitOfMeasure].nil?
                                       @NameSpace.issueWarning(466, 'altunits')
                                    end

                                    # altitude datum 4.2.2.4 (altenc) - altitude units (required)
                                    unless hVDatum[:encodingMethod].nil?
                                       @xml.tag!('altenc', hVDatum[:encodingMethod])
                                    end
                                    if hVDatum[:encodingMethod].nil?
                                       @NameSpace.issueWarning(467, 'altenc')
                                    end

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
