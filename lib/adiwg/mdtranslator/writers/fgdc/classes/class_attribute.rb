# FGDC <<Class>> Attribute
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2018-01-24 original script

require_relative '../fgdc_writer'
require_relative 'class_dataDomain'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Attribute

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hAttribute, inContext = nil)
                  
                  # classes used
                  domainClass = DataDomain.new(@xml, @hResponseObj)

                  # attribute 5.1.2.1 (attrlabl) - attribute label (required)
                  # <- attribute.attributeCode
                  unless hAttribute[:attributeCode].nil?
                     @xml.tag!('attrlabl', hAttribute[:attributeCode])
                  end
                  if hAttribute[:attributeCode].nil?
                     @NameSpace.issueWarning(10, 'attrlabl', inContext)
                  end

                  # attribute 5.1.2.2 (attrdef) - attribute definition (required)
                  # <- attribute.attributeDefinition
                  unless hAttribute[:attributeDefinition].nil?
                     @xml.tag!('attrdef', hAttribute[:attributeDefinition])
                  end
                  if hAttribute[:attributeDefinition].nil?
                     @NameSpace.issueWarning(11, 'attrdef', inContext)
                  end

                  # attribute 5.1.2.3 (attrdefs) - attribute definition source (required)
                  # <- take title from first attributeReference {citation}
                  unless hAttribute[:attributeReference].empty?
                     unless hAttribute[:attributeReference].empty?
                        @xml.tag!('attrdefs', hAttribute[:attributeReference][:title])
                     end
                  end
                  if hAttribute[:attributeReference].empty?
                     @NameSpace.issueWarning(12, 'attrdefs', inContext)
                  end

                  # set attribute context
                  outContext = nil
                  unless hAttribute[:attributeCode].nil?
                     outContext = 'attribute code ' + hAttribute[:attributeCode]
                     unless inContext.nil?
                        outContext = inContext + ' ' + outContext
                     end
                  end

                  # attribute 5.1.2.4 (attrdomv) - attribute domain value
                  # enumerated domain <- dictionary.domainItems[]
                  # codeset domain <- dictionary.domainReference and no dictionary.domainItems[]
                  # unrepresented domain <- dictionary.domainDescription and no dictionary.domainItems[]
                  unless hAttribute[:domainId].nil?
                     domainClass.writeXML(hAttribute[:domainId])
                  end

                  # attribute 5.1.2.4 (attrdomv) - attribute domain value
                  # attribute 5.1.2.4.2 (rdom) - value range
                  # <- attribute.valueRange[]
                  hAttribute[:valueRange].each do |hRange|
                     unless hRange.empty?
                        @xml.tag!('attrdomv') do
                           @xml.tag!('rdom') do

                              # value range 5.1.2.4.2.1 (rdommin) - range minimum (required)
                              # <- valueRange[].minRangeValue
                              unless hRange[:minRangeValue].nil?
                                 @xml.tag!('rdommin', hRange[:minRangeValue])
                              end
                              if hRange[:minRangeValue].nil?
                                 @NameSpace.issueWarning(13,'rdommin', outContext)
                              end

                              # value range 5.1.2.4.2.2 (rdommax) - range maximum (required)
                              # <- valueRange[].maxRangeValue
                              unless hRange[:maxRangeValue].nil?
                                 @xml.tag!('rdommax', hRange[:maxRangeValue])
                              end
                              if hRange[:maxRangeValue].nil?
                                 @NameSpace.issueWarning(14,'rdommax', outContext)
                              end

                              # value range 5.1.2.4.2.3 (attrunit) - unit of measure
                              # <- attribute.unitOfMeasure
                              unless hAttribute[:unitOfMeasure].nil?
                                 @xml.tag!('attrunit', hAttribute[:unitOfMeasure])
                              end
                              if hAttribute[:unitOfMeasure].nil? && @hResponseObj[:writerShowTags]
                                 @xml.tag!('attrunit')
                              end

                              # value range 5.1.2.4.2.4 (attrmres) - unit of measure resolution
                              # <- attribute.measureResolution
                              unless hAttribute[:measureResolution].nil?
                                 @xml.tag!('attrmres', hAttribute[:measureResolution])
                              end
                              if hAttribute[:measureResolution].nil? && @hResponseObj[:writerShowTags]
                                 @xml.tag!('attrmres')
                              end

                           end
                        end
                     end
                  end

                  # attribute 5.1.2.5 & 5.1.2.6 (begdatea & enddatea) - attribute value date range
                  # <- attribute.timePeriod[]
                  hAttribute[:timePeriod].each do |hTimePeriod|

                     # date range 5.1.2.5 (begdatea) -  begin date range
                     # <- timePeriod.startDateTime
                     unless hTimePeriod[:startDateTime].empty?
                        hDate = hTimePeriod[:startDateTime]
                        begDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:dateTime], hDate[:dateResolution])
                        begDate.gsub!(/[-]/,'')
                        unless begDate == 'ERROR'
                           @xml.tag!('begdatea', begDate)
                        end
                        if begDate == 'ERROR'
                           @NameSpace.issueWarning(15,nil, outContext)
                        end
                     end
                     if hTimePeriod[:startDateTime].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('begdatea')
                     end

                     # date range 5.1.2.6 (enddatea) -  end date range
                     # <- timePeriod.endDateTime
                     unless hTimePeriod[:endDateTime].empty?
                        hDate = hTimePeriod[:endDateTime]
                        endDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:dateTime], hDate[:dateResolution])
                        endDate.gsub!(/[-]/,'')
                        unless endDate == 'ERROR'
                           @xml.tag!('enddatea', endDate)
                        end
                        if endDate == 'ERROR'
                           @NameSpace.issueWarning(16,nil, outContext)
                        end
                     end
                     if hTimePeriod[:endDateTime].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('enddatea')
                     end

                  end

                  # attribute 5.1.2.7 (attrvai) - attribute value accuracy information
                  # not supported

                  # entity attribute 5.1.2.7.1 (attrva) - attribute value accuracy
                  # -> not supported

                  # entity attribute 5.1.2.7.2 (attrvae) - attribute value accuracy explanation
                  # -> not supported

                  # entity attribute 5.1.2.8 (attrmfrq) - attribute measurement frequency
                  # -> not supported; same as resource maintenance but at attribute level

               end # writeXML
            end # Attribute

         end
      end
   end
end
