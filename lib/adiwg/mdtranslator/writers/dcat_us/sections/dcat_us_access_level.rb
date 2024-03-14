require 'jbuilder'

module ADIWG
   module Mdtranslator
      module Writers
         module Dcat_us
            module AccessLevel

               def self.build(intObj)

                  publicArray = ['unclassified', 'unrestricted', 'licenseUnrestricted', 'licenseEndUser']
                  nonPublicArray = ['restricted','confidential','secret','topSecret','forOfficialUseOnly','protected','intellectualPropertyRights','restricted','otherRestrictions','private','statutory','confidential','traditionalKnowledge','personallyIdentifiableInformation']
                  restrictedPublicArray = ['sensitiveButUnclassified','limitedDistribution','copyright','patent','patentPending','trademark','license','licenseDistributor','in-confidence','threatenedOrEndangered']

                  resourceInfo = intObj[:metadata][:resourceInfo]
                  legalConstraints = resourceInfo[:constraints]&.select { |constraint| constraint[:type] == 'legal' }
                  securityConstraints = resourceInfo[:constraints]&.select { |constraint| constraint[:type] == 'security' }

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
                        accessLevelCodes.push(*codes)
                     end
                  end

                  # return access level that is most restrictive
                  accessLevelCodes.uniq.each do |code|
                     if nonPublicArray.include? code
                        return 'non-public'
                     end
                  end
                  accessLevelCodes.uniq.each do |code|
                     if restrictedPublicArray.include? code
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

