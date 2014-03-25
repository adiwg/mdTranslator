# unpack distribution info
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2013-09-23 original script
# 	Stan Smith 2013-11-27 changed to receive single distributor rather than array
# 	Stan Smith 2013-12-18 changed to unpack contact using responsible party

require Rails.root + 'metadataxx/internal/internal_metadata_obj'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_onlineResource'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_dateTime'
require Rails.root + 'metadataxx/readers/adiwg_v1/lib/modules/module_responsibleParty'

module AdiwgV1DistributionInfo

	def self.unpack(hDistributor)

		# instance classes needed in script
		intMetadataClass = InternalMetadata.new
		intDistributor = intMetadataClass.newDistributor

		# distributor - distribution contact
		if hDistributor.has_key?('distributorContact')
			hContact = hDistributor['distributorContact']
			unless hContact.empty?
				intDistributor[:distContact] = AdiwgV1ResponsibleParty.unpack(hContact)
			end
		end

		# distributor - distribution order process
		if hDistributor.has_key?('distributionOrderProcess')
			aDistOrder = hDistributor['distributionOrderProcess']
			unless aDistOrder.empty?
				aDistOrder.each do |distOrderProcess|

					intDistOrder = intMetadataClass.newDistOrder

					if distOrderProcess.has_key?('fees')
						s = distOrderProcess['fees']
						if s != ''
							intDistOrder[:fees] = s
						end
					end

					if distOrderProcess.has_key?('plannedAvailabilityDateTime')
						s = distOrderProcess['plannedAvailabilityDateTime']
						if s != ''
							intDistOrder[:plannedDateTime] = AdiwgV1DateTime.unpack(s)
						end
					end

					if distOrderProcess.has_key?('orderingInstructions')
						s = distOrderProcess['orderingInstructions']
						if s != ''
							intDistOrder[:orderInstructions] = s
						end
					end

					if distOrderProcess.has_key?('turnaround')
						s = distOrderProcess['turnaround']
						if s != ''
							intDistOrder[:turnaround] = s
						end
					end

					intDistributor[:distOrderProc] << intDistOrder

				end
			end
		end

		# distributor - distribution format
		if hDistributor.has_key?('distributorFormat')
			aDistFormat = hDistributor['distributorFormat']
			unless aDistFormat.empty?

				aDistFormat.each do |distFormat|
					intResFormat = intMetadataClass.newResourceFormat

					if distFormat.has_key?('name')
						s = distFormat['name']
						if s != ''
							intResFormat[:formatName] = s
						end
					end

					if distFormat.has_key?('version')
						s = distFormat['version']
						if s != ''
							intResFormat[:formatVersion] = s
						end
					end

					intDistributor[:distFormat] << intResFormat
				end
			end
		end

		# distributor - distribution transfer options
		if hDistributor.has_key?('distributorTransferOptions')
			aDistTransOpt = hDistributor['distributorTransferOptions']
			unless aDistTransOpt.empty?

				aDistTransOpt.each do |distTransOpt|
					intTransOpt = intMetadataClass.newDigitalTransOption

					if distTransOpt.has_key?('online')
						aOnlineOption = distTransOpt['online']
						intTransOpt[:online] = AdiwgV1OnlineResource.unpack(aOnlineOption)
					end

					if distTransOpt.has_key?('offline')
						intOfflineOpt = intMetadataClass.newMedium
						distOfflineOpt = distTransOpt['offline']
						if distOfflineOpt.has_key?('name')
							s = distOfflineOpt['name']
							if s != ''
								intOfflineOpt[:mediumName] = s
							end
						end

						if distOfflineOpt.has_key?('mediumFormat')
							s = distOfflineOpt['mediumFormat']
							if s != ''
								intOfflineOpt[:mediumFormat] = s
							end
						end

						if distOfflineOpt.has_key?('mediumNote')
							s = distOfflineOpt['mediumNote']
							if s != ''
								intOfflineOpt[:mediumNote] = s
							end
						end

						intTransOpt[:offline] = intOfflineOpt
					end

					intDistributor[:distTransOption] << intTransOpt
				end
			end
		end

		return intDistributor
	end

end
