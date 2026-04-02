# MdTranslator - minitest of
# reader / dcat_us / module_language

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_language'

class TestReaderDcatUsLanguage < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Language
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_language_multiple
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hMetadataInfo = @@intMetadataClass.newMetadataInfo

      @@NameSpace.unpack(hIn, hMetadataInfo, hResponse)

      assert_equal 'en-US', hMetadataInfo[:defaultMetadataLocale][:languageCode]
      assert_equal 1, hMetadataInfo[:otherMetadataLocales].length
      assert_equal 'es-MX', hMetadataInfo[:otherMetadataLocales][0][:languageCode]
      assert hResponse[:readerExecutionPass]
   end

   def test_language_single
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['language'] = ['en-US']
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hMetadataInfo = @@intMetadataClass.newMetadataInfo

      @@NameSpace.unpack(hIn, hMetadataInfo, hResponse)

      assert_equal 'en-US', hMetadataInfo[:defaultMetadataLocale][:languageCode]
      assert_empty hMetadataInfo[:otherMetadataLocales]
   end

   def test_language_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('language')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hMetadataInfo = @@intMetadataClass.newMetadataInfo

      @@NameSpace.unpack(hIn, hMetadataInfo, hResponse)

      assert_empty hMetadataInfo[:defaultMetadataLocale]
   end

end
