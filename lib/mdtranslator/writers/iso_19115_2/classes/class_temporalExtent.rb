# ISO <<Class>> EX_TemporalExtent
# writer output in XML

# History:
# 	Stan Smith 2013-11-15 original script
#   Stan Smith 2014-06-03 add support for date as time instant
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_timeInstant'
require 'class_timePeriod'

class EX_TemporalExtent

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hTempEle)

		# classes used by MD_Metadata
		intMetadataClass = InternalMetadata.new
		timeInstClass = TimeInstant.new(@xml)
		timePeriodClass = TimePeriod.new(@xml)

		@xml.tag!('gmd:EX_TemporalExtent') do

			# temporal extent - date - not supported by ISO
			# ... convert date to time instant
			hDate =  hTempEle[:date]
			unless hDate.empty?
				intTimeInst = intMetadataClass.newTimeInstant
				intTimeInst[:timePosition] = hDate
				@xml.tag!('gmd:extent') do
					timeInstClass.writeXML(intTimeInst)
				end
			end

			# temporal extent - time instant
			hTimeInst = hTempEle[:timeInstant]
			unless hTimeInst.empty?
				@xml.tag!('gmd:extent') do
					timeInstClass.writeXML(hTimeInst)
				end
			end

			# temporal extent - time period
			hTimePeriod = hTempEle[:timePeriod]
			unless hTimePeriod.empty?
				@xml.tag!('gmd:extent') do
					timePeriodClass.writeXML(hTimePeriod)
				end
			end

		end

	end

end