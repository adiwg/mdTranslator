# Reader - fgdc to internal data structure
# unpack fgdc point and vector data organization

# History:
#  Stan Smith 2017-09-01 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module PointVector

               def self.unpack(xPtVec, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # point and vector object 3.3.1 (sdtsterm) - SDTS term []
                  axSDTSterm = xPtVec.xpath('./sdtsterm')
                  unless axSDTSterm.empty?
                     hVectorInfo = intMetadataClass.newVectorInfo

                     axSDTSterm.each do |xTerm|
                        hVectorObj = intMetadataClass.newVectorObject

                        # SDTS term 3.3.1.1 (sdtstype) - point and vector object type (required)
                        # -> spatialRepresentation.vectorInfo.vectorObject.objectType
                        sdtsType = xTerm.xpath('./sdtstype').text
                        unless sdtsType.empty?
                           hVectorObj[:objectType] = sdtsType
                        end
                        if sdtsType.empty?
                           hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial data SDTS object type is missing'
                        end

                        # SDTS term 3.3.1.2 (ptvctcnt) - point and vector object count
                        # -> spatialRepresentation.vectorInfo.vectorObject.objectCount
                        ptvCount = xTerm.xpath('./ptvctcnt').text
                        unless ptvCount.empty?
                           hVectorObj[:objectCount] = ptvCount.to_i
                        end

                        hVectorInfo[:vectorObject] << hVectorObj
                     end

                     hSpatialRepresentation = intMetadataClass.newSpatialRepresentation
                     hSpatialRepresentation[:vectorRepresentation] = hVectorInfo
                     hResourceInfo[:spatialRepresentations] << hSpatialRepresentation
                  end

                  # point and vector object 3.3.2 (vpfterm) - VPF terms description
                  xVPFterm = xPtVec.xpath('./vpfterm')
                  unless xVPFterm.empty?
                     hVectorInfo = intMetadataClass.newVectorInfo

                     # VPF term 3.3.2.1 (vpflevel) - VPF topology level (required)
                     # -> spatialRepresentation.vectorInfo.topologyLevel
                     level = xVPFterm.xpath('vpflevel').text
                     unless level.empty?
                        hVectorInfo[:topologyLevel] = level.to_i
                     end
                     if level.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial data VPF topology level is missing'
                     end

                     # VPF term 3.3.2.2 (vpfinfo) - VPF point and vector object information [] (required)
                     axVPFInfo = xVPFterm.xpath('./vpfinfo')
                     unless axVPFInfo.empty?
                        axVPFInfo.each do |xInfo|
                           hVectorObj = intMetadataClass.newVectorObject

                           # VPF point and object 3.3.2.2.1 (vpftype) - VPF point and vector object type (required)
                           # -> spatialRepresentation.vectorInfo.vectorObject.objectType
                           vpfType = xInfo.xpath('./vpftype').text
                           unless vpfType.empty?
                              hVectorObj[:objectType] = vpfType
                           end
                           if vpfType.empty?
                              hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial data VPF object type is missing'
                           end

                           # VPF point and object 3.3.2.2.2 (ptvctcnt) - VPF point and vector object count
                           # -> spatialRepresentation.vectorInfo.vectorObject.objectCount
                           vpfCount = xInfo.xpath('./ptvctcnt').text
                           unless vpfCount.empty?
                              hVectorObj[:objectCount] = vpfCount.to_i
                           end

                           hVectorInfo[:vectorObject] << hVectorObj
                        end

                        hSpatialRepresentation = intMetadataClass.newSpatialRepresentation
                        hSpatialRepresentation[:vectorRepresentation] = hVectorInfo
                        hResourceInfo[:spatialRepresentations] << hSpatialRepresentation
                     end
                     if axVPFInfo.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial data VPF object information is missing'
                     end

                  end

                  # error message
                  if axSDTSterm.empty? && xVPFterm.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC spatial data point-vector terms are missing'
                  end

                  return hResourceInfo

               end
            end

         end
      end
   end
end
