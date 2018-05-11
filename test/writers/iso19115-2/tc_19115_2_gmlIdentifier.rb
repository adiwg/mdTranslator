# MdTranslator - minitest of
# writers / iso19115_2 / class_gmlIdentifier

# History:
#  Stan Smith 2018-04-24 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-03 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152GmlIdentifier < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hFeature = TDClass.build_feature('id001', 'point')
   TDClass.add_properties(hFeature)
   hFeature[:properties][:identifier][0][:namespace] = 'identifier namespace one'
   hFeature[:properties][:identifier] << { identifier: 'geoJson properties identifier two'}
   hFeature[:properties][:identifier][1][:namespace] = 'identifier namespace two'

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   hGeoExtent[:geographicElement] = []
   hGeoExtent[:geographicElement] << hFeature

   @@mdHash = mdHash

   def test_gmlIdentifier_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_gmlIdentifier',
                                                '//gmd:geographicElement[1]',
                                                '//gmd:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
