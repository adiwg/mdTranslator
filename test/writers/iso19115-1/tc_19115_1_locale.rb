# MdTranslator - minitest of
# writers / iso19115_1 / class_locale

# History:
#  Stan Smith 2019-05-08 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Locale < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:otherMetadataLocale] = []
   mdHash[:metadata][:resourceInfo][:otherResourceLocale] = []
   mdHash[:metadata][:metadataInfo][:defaultMetadataLocale] = TDClass.build_locale('eng','UTF-16','FJI')
   mdHash[:metadata][:metadataInfo][:otherMetadataLocale] << TDClass.build_locale('fre','UTF-16','COG')
   mdHash[:metadata][:metadataInfo][:otherMetadataLocale] << TDClass.build_locale('spa','UTF-16','CUB')
   mdHash[:metadata][:resourceInfo][:defaultResourceLocale] = TDClass.build_locale('eng','UTF-16','HND')
   mdHash[:metadata][:resourceInfo][:otherResourceLocale] << TDClass.build_locale('fre','UTF-16','COG')
   mdHash[:metadata][:resourceInfo][:otherResourceLocale] << TDClass.build_locale('spa','UTF-16','FJI')

   @@mdHash = mdHash

   def test_locale_metadata_default

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mdb:defaultLocale[1]',
                                                '//mdb:defaultLocale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_metadata_other

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mdb:otherLocale[1]',
                                                '//mdb:otherLocale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mdb:otherLocale[2]',
                                                '//mdb:otherLocale', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_resource_default

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mri:defaultLocale[1]',
                                                '//mri:defaultLocale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_resource_other

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mri:otherLocale[1]',
                                                '//mri:otherLocale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_locale',
                                                '//mri:otherLocale[2]',
                                                '//mri:otherLocale', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
