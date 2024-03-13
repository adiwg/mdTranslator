require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module AccessLevel

               def self.build(intObj)

                  publicArray = ['public','unclassified', 'unrestricted', 'licenseUnrestricted', 'licenseEndUser']
                  nonPublicArray = ['Non-public','restricted','confidential','secret','topSecret','forOfficialUseOnly','protected','intellectualPropertyRights','restricted','otherRestrictions','private','statutory','confidential','traditionalKnowledge','personallyIdentifiableInformation']
                  restrictedPublicArray = ['Restricted public','sensitiveButUnclassified','limitedDistribution','copyright','patent','patentPending','trademark','license','licenseDistributor','in-confidence','threatenedOrEndangered']

                  resourceInfo = intObj[:metadata][:resourceInfo]
                  legalConstraints = resourceInfo[:constraints]&.select { |constraint| constraint[:type] == 'legal' }
                  securityConstraints = resourceInfo[:constraints]&.select { |constraint| constraint[:type] == 'security' }

                  accessLevels = []
                  accessLevelCodes = []

                  # Gather codes from security constraints and legal constraints
                  unless securityConstraints.empty?
                     securityConstraints.each do |securityConstraint|
                        code = securityConstraint[:securityConstraint][:classCode]
                        accessLevelCodes << code                        
                     end
                  end
                  unless legalConstraints.empty?
                     legalConstraints.each do |legalConstraint|
                        codes = legalConstraint.dig(:legalConstraint, :accessCodes)
                        accessLevelCodes << codes
                     end
                     
                  end
                  
                  # return access level that is most restrictive
                  accessLevelCodes.uniq.each do |code|
                     if nonPublicArray.include? code
                        return 'non-public'
                     elsif restrictedPublicArray.include? code
                        return 'restricted public'
                     end
                  end
                  
                  return 'public'
               end           

            end
         end
      end
   end
end

