# ISO <<Class>> MD_StandardOrderProcess
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script

require 'builder'
require Rails.root + 'metadata/internal/module_dateTimeFun'

class MD_StandardOrderProcess

	def initialize(xml)
		@xml = xml
	end

	def writeXML(orderProcess)

		# classes used

		@xml.tag!('gmd:MD_StandardOrderProcess') do

			# order process - fees
			s = orderProcess[:fees]
			if !s.nil?
				@xml.tag!('gmd:fees') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:fees')
			end

			# order process - plannedAvailableDateTime
			hDateTime = orderProcess[:plannedDateTime]
			if !hDateTime.empty?
				paDateTime = hDateTime[:dateTime]
				paDateRes = hDateTime[:dateResolution]
				if paDateTime.nil?
					@xml.tag!('gmd:plannedAvailableDateTime')
				else
					@xml.tag!('gmd:plannedAvailableDateTime') do
						dateTimeStr =
							AdiwgDateTimeFun.stringDateTimeFromDateTime(paDateTime,paDateRes)
						@xml.tag!('gco:DateTime',dateTimeStr)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:plannedAvailableDateTime')
			end

			# order process - orderingInstructions
			s = orderProcess[:orderInstructions]
			if !s.nil?
				@xml.tag!('gmd:orderingInstructions') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:orderingInstructions')
			end

			# order process - turnaround
			s = orderProcess[:turnaround]
			if !s.nil?
				@xml.tag!('gmd:turnaround') do
					@xml.tag!('gco:CharacterString',s)
				end
			elsif $showEmpty
				@xml.tag!('gmd:turnaround')
			end

		end

	end

end
