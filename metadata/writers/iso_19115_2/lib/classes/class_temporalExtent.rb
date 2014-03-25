# ISO <<Class>> EX_TemporalExtent
# writer output in XML

# History:
# 	Stan Smith 2013-11-15 original script

require 'builder'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_timeInstant'
require Rails.root + 'metadata/writers/iso_19115_2/lib/classes/class_timePeriod'

class EX_TemporalExtent

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hTempEle)

		# classes used by MD_Metadata
		timeInstClass = TimeInstant.new(@xml)
		timePeriodClass = TimePeriod.new(@xml)

		@xml.tag!('gmd:EX_TemporalExtent') do

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