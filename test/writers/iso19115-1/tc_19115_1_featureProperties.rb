# MdTranslator - minitest of
# writers / iso19115_1 / class_featureProperties

# History:
#  Stan Smith 2019-04-25 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151FeatureProperties < TestWriter191151Parent

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
      hProp = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0][:properties]
      hProp[:featureName].delete_at(1)
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_featureProperties',
                                                '//gex:geographicElement[1]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_featureProperties',
                                                '//gex:geographicElement[2]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hProp = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0][:properties]

      # empty elements
      hProp[:description] = ''
      hProp[:featureName] = []
      hProp[:featureScope] = ''
      hProp[:acquisitionMethod] = ''
      hProp[:identifier] = []
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_featureProperties',
                                                '//gex:geographicElement[3]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hProp[:nonElement] = 'non element'
      hProp.delete(:description)
      hProp.delete(:featureName)
      hProp.delete(:featureScope)
      hProp.delete(:acquisitionMethod)
      hProp.delete(:identifier)
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_featureProperties',
                                                '//gex:geographicElement[3]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_featureProperties_missing_section

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:geographicElement][0].delete(:properties)
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_featureProperties',
                                                '//gex:geographicElement[3]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
