# MdTranslator - minitest of
# writers / iso19115_2 / class_locale

# History:
#  Stan Smith 2018-04-25 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Locale < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:language[1]',
                                                '//gmd:language', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:characterSet[1]',
                                                '//gmd:characterSet', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_metadata_other

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:locale[1]',
                                                '//gmd:locale', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:locale[2]',
                                                '//gmd:locale', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:locale[3]',
                                                '//gmd:locale', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_resource_default

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:language[2]',
                                                '//gmd:language', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:characterSet[2]',
                                                '//gmd:characterSet', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_locale_resource_other

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:language[3]',
                                                '//gmd:language', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_locale',
                                                '//gmd:language[4]',
                                                '//gmd:language', 3)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
