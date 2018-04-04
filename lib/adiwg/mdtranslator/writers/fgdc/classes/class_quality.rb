# FGDC <<Class>> Quality
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-23 refactored error and warning messaging
#  Stan Smith 2017-12-15 original script

require_relative 'class_lineage'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Quality

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(intObj)

                  # classes used
                  lineageClass = Lineage.new(@xml, @hResponseObj)

                  # data quality 2.1 (attracc) - attribute accuracy (not implemented)
                  if @hResponseObj[:writerShowTags]
                     @xml.tag!('attracc', 'Not Reported')
                  end

                  # data quality 2.2 (logic) - logical consistency (not implemented) (required)
                  @xml.tag!('logic', 'Not Reported')

                  # data quality 2.3 (complete) - completion report (not implemented) (required)
                  @xml.tag!('complete', 'Not Reported')

                  # data quality 2.4 (position) - positional accuracy (not implemented)
                  if @hResponseObj[:writerShowTags]
                     @xml.tag!('position', 'Not Reported')
                  end

                  # data quality 2.5 (lineage) - lineage (required)
                  unless intObj[:metadata][:lineageInfo].empty?
                     @xml.tag!('lineage') do
                        lineageClass.writeXML(intObj[:metadata][:lineageInfo])
                     end
                  end
                  if intObj[:metadata][:lineageInfo].empty?
                     @NameSpace.issueWarning(350, nil, 'data quality section')
                  end

                  # data quality 2.6 (cloud) - cloud cover (not implemented)
                  if @hResponseObj[:writerShowTags]
                     @xml.tag!('cloud', 'Not Reported')
                  end

               end # writeXML
            end # Quality

         end
      end
   end
end
