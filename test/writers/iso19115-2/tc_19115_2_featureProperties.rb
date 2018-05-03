# MdTranslator - minitest of
# writers / iso19115_2 / class_featureProperties

# History:
#  Stan Smith 2018-04-23 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-03 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152FeatureProperties < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hFeature = TDClass.build_feature('id001', 'point')
   TDClass.add_properties(hFeature)

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   hGeoExtent[:geographicElement] = []
   hGeoExtent[:geographicElement] << hFeature

   @@mdHash = mdHash

   def test_featureProperties_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_featureProperties',
                                                '//gmd:geographicElement[2]',
                                                '//gmd:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hProp = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0][:properties]
      hProp[:featureName].delete_at(1)
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_featureProperties',
                                                '//gmd:geographicElement[3]',
                                                '//gmd:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hProp = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0][:properties]
      hProp[:nonElement] = 'non element'
      hProp.delete(:description)
      hProp.delete(:featureName)
      hProp.delete(:featureScope)
      hProp.delete(:acquisitionMethod)
      hProp.delete(:identifier)
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_featureProperties',
                                                '//gmd:geographicElement[4]',
                                                '//gmd:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_missing_section

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0].delete(:properties)
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_featureProperties',
                                                '//gmd:geographicElement[4]',
                                                '//gmd:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
