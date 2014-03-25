# ISO <<Class>> DQ_DataQuality
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script

require 'builder'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/codelists/code_scope'
require Rails.root + 'metadataxx/writers/iso_19115_2/lib/classes/class_lineage'

class DQ_DataQuality

	def initialize(xml)
		@xml = xml
	end

	def writeXML(hDataQ)

		# classes used
		scopeCode = MD_ScopeCode.new(@xml)
		lineClass = LI_Lineage.new(@xml)

		@xml.tag!('gmd:DQ_DataQuality') do

			# data quality - scope - required
			s = hDataQ[:dataScope]
			if s.nil?
				@xml.tag!('gmd:scope',{'gco:nilReason'=>'missing'})
			else
				@xml.tag!('gmd:scope') do
					@xml.tag!('gmd:DQ_Scope') do
						@xml.tag!('gmd:level') do
							scopeCode.writeXML(s)
						end
					end
				end
			end

			# date quality - report

			# data quality - lineage
			hLineage = hDataQ[:dataLineage]
			if !hLineage.empty?
				@xml.tag!('gmd:lineage') do
					lineClass.writeXML(hLineage)
				end
			elsif $showEmpty
				@xml.tag!('gmd:lineage')
			end

		end

	end

end
