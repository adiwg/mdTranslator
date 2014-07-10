# ISO <<Class>> MD_DigitalTransferOptions
# writer output in XML

# History:
# 	Stan Smith 2013-09-26 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure

require 'class_onlineResource'
require 'class_medium'

class MD_DigitalTransferOptions

	def initialize(xml)
		@xml = xml
	end

	def writeXML(transOption)

		# classes used
		olResClass = CI_OnlineResource.new(@xml)
		medClass = MD_Medium.new(@xml)

		@xml.tag!('gmd:MD_DigitalTransferOptions') do

			# digital transfer options - online [] - CI_OnlineResource
			aOnTranOpts = transOption[:online]
			if !aOnTranOpts.empty?
				aOnTranOpts.each do |olTranOpt|
				    @xml.tag!('gmd:onLine') do
						olResClass.writeXML(olTranOpt)
					end
				end
			elsif $showEmpty
				@xml.tag!('gmd:onLine')
			end

			# digital transfer options - offline - MD_Medium
			hOffTranOpt = transOption[:offline]
			if !hOffTranOpt.empty?
				@xml.tag!('gmd:offLine') do
					medClass.writeXML(hOffTranOpt)
				end
			elsif $showEmpty
				@xml.tag!('gmd:offLine')
			end

		end

	end

end
