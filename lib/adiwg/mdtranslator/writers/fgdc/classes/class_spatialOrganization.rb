# FGDC <<Class>> SpatialOrganization
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-12-21 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class SpatialOrganization

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hResourceInfo)

                  # spatial organization 3.1 (indspref) - Indirect Spatial Reference
                  # <- hResourceInfo.spatialReferenceSystems.systemIdentifier.identifier = 'indirect' (first)
                  haveIndirect = false
                  hResourceInfo[:spatialReferenceSystems].each do |hSystem|
                     unless hSystem[:systemIdentifier].empty?
                        if hSystem[:systemIdentifier][:identifier] == 'indirect'
                           unless hSystem[:systemIdentifier][:description].empty?
                              @xml.tag!('indspref', hSystem[:systemIdentifier][:description])
                              haveIndirect = true
                              break
                           end
                        end
                     end
                  end
                  if !haveIndirect && @hResponseObj[:writerShowTags]
                     @xml.tag!('indspref')
                  end

                  # spatial organization 3.2 (direct) - Direct Spatial Reference Method
                  # <- resourceInfo.spatialRepresentationTypes
                  # take first that match ['point' | 'vector' | 'grid']
                  direct = nil
                  hResourceInfo[:spatialRepresentationTypes].each do |type|
                     direct = 'Point' if type == 'point'
                     direct = 'Vector' if type == 'vector'
                     direct = 'Raster' if type == 'grid'
                    unless direct.nil?
                       @xml.tag!('direct', direct)
                       break
                    end
                  end
                  if direct.nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('direct')
                  end

                  # spatial organization 3.3 (ptvctinf) - point and vector object information
                  # <- resourceInfo.spatialRepresentations.vectorRepresentation (first)
                  if direct == 'Point' || direct == 'Vector'
                     hResourceInfo[:spatialRepresentations].each do |hSpaceRep|
                        unless hSpaceRep[:vectorRepresentation].empty?
                           hVectorRep = hSpaceRep[:vectorRepresentation]
                           unless hVectorRep.empty?
                              @xml.tag!('ptvctinf') do
                                 if hVectorRep[:topologyLevel].nil?

                                    # spatial organization point and vector object 3.3.1 (sdtsterm) - SDTS term []
                                    hVectorRep[:vectorObject].each do |hVecObj|
                                       @xml.tag!('sdtsterm') do

                                          # spatial organization point and vector object 3.3.1.1 (sdtstype) - SDTS object type (requied)
                                          @xml.tag!('sdtstype', hVecObj[:objectType])

                                          # spatial organization point and vector object 3.3.1.2 (ptvctcnt) - SDTS count
                                          unless hVecObj[:objectCount].nil?
                                             @xml.tag!('ptvctcnt', hVecObj[:objectCount])
                                          end
                                          if hVecObj[:objectCount].nil?
                                             @xml.tag!('ptvctcnt')
                                          end

                                       end
                                    end

                                 else

                                    # point and vector object 3.3.2 (vpfterm) - VPF terms description
                                    @xml.tag!('vpfterm') do

                                       # VPF term 3.3.2.1 (vpflevel) - VPF topology level
                                       @xml.tag!('vpflevel', hVectorRep[:topologyLevel])

                                       # VPF term 3.3.2.2 (vpfinfo) - VPF point and vector object information []
                                       hVectorRep[:vectorObject].each do |hVecObj|
                                          @xml.tag!('vpfinfo') do

                                             # spatial organization point and vector object 3.3.2.2.1 (vpftype) - VPF object type (requied)
                                             @xml.tag!('vpftype', hVecObj[:objectType])

                                             # spatial organization point and vector object 3.3.2.2.2 (ptvctcnt) - VPF object type
                                             unless hVecObj[:objectCount].nil?
                                                @xml.tag!('ptvctcnt', hVecObj[:objectCount])
                                             end
                                             if hVecObj[:objectCount].nil?
                                                @xml.tag!('ptvctcnt')
                                             end

                                          end
                                       end

                                    end

                                 end
                              end
                              break
                           end

                        end
                     end
                  end

                  # spatial organization 3.4 (rastinfo) - point and vector object information
                  # <- resourceInfo.spatialRepresentations.gridRepresentation (first)
                  if direct == 'Raster'
                     hResourceInfo[:spatialRepresentations].each do |hSpaceRep|
                        if hSpaceRep[:gridRepresentation]
                           hGridRep = hSpaceRep[:gridRepresentation]
                           @xml.tag!('rastinfo') do

                              # spatial organization raster 3.4.1 (rasttype) - raster type (required)
                              unless hGridRep[:cellGeometry].empty?
                                 @xml.tag!('rasttype', hGridRep[:cellGeometry])
                              end
                              if hGridRep[:cellGeometry].empty?
                                 @NameSpace.issueWarning(380, 'rasttype')
                              end

                              # spatial organization raster 3.4.2 (rowcount) - row count
                              hGridRep[:dimension].each do |hDimension|
                                 if hDimension[:dimensionType] == 'row'
                                    unless hDimension[:dimensionSize].nil?
                                       @xml.tag!('rowcount', hDimension[:dimensionSize])
                                    end
                                 end
                              end

                              # spatial organization raster 3.4.2 (colcount) - column count
                              hGridRep[:dimension].each do |hDimension|
                                 if hDimension[:dimensionType] == 'column'
                                    unless hDimension[:dimensionSize].nil?
                                       @xml.tag!('colcount', hDimension[:dimensionSize])
                                    end
                                 end
                              end

                              # spatial organization raster 3.4.2 (vrtcount) - depth count
                              hGridRep[:dimension].each do |hDimension|
                                 if hDimension[:dimensionType] == 'vertical'
                                    unless hDimension[:dimensionSize].nil?
                                       @xml.tag!('vrtcount', hDimension[:dimensionSize])
                                    end
                                 end
                              end

                           end
                           break
                        end
                     end
                  end

               end # writeXML
            end # SpatialOrganization

         end
      end
   end
end
