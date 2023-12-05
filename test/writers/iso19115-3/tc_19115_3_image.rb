# MdTranslator - minitest of
# writers / iso19115_3 / class_image

# History:
#  Stan Smith 2019-05-07 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Image < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCoverage = TDClass.build_coverageDescription
   TDClass.add_imageDescription(hCoverage)
   mdHash[:metadata][:resourceInfo][:coverageDescription] = []
   mdHash[:metadata][:resourceInfo][:coverageDescription] << hCoverage

   @@mdHash = mdHash

   def test_image_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_image',
                                                '//mdb:contentInfo[1]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_image_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hImage = hIn[:metadata][:resourceInfo][:coverageDescription][0][:imageDescription]

      # empty elements
      hImage[:illuminationElevationAngle] = ''
      hImage[:illuminationAzimuthAngle] = ''
      hImage[:imagingCondition] = ''
      hImage[:imageQualityCode] = ''
      hImage[:cloudCoverPercent] = ''
      hImage[:compressionQuantity] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_image',
                                                '//mdb:contentInfo[2]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hImage[:nonElement] = 'nonValue'

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_image',
                                                '//mdb:contentInfo[2]',
                                                '//mdb:contentInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
