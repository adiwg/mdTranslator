# ISO <<Class>> MD_Distribution
# writer output in XML

# History:
# 	Stan Smith 2013-09-25 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure

require 'class_distributor'

class MD_Distribution

	def initialize(xml)
		@xml = xml
	end

	def writeXML(aDistributors)

		# classes used
		distributorClass = MD_Distributor.new(@xml)

		@xml.tag!('gmd:MD_Distribution') do

			# distribution - distributor - required
			unless aDistributors.empty?
				aDistributors.each do |hDistributor|
					@xml.tag!('gmd:distributor') do
						distributorClass.writeXML(hDistributor)
					end
				end
			end

		end

	end

end
