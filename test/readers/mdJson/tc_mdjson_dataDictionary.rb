# MdTranslator - minitest of
# reader / mdJson / module_dataDictionary

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-11-09 add dictionary description
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_dataDictionary'

class TestReaderMdJsonDataDictionary < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DataDictionary

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.dataDictionary
   mdHash[:locale] << TDClass.locale
   mdHash[:locale] << TDClass.locale
   mdHash[:domain] << TDClass.dictionaryDomain
   mdHash[:domain] << TDClass.dictionaryDomain
   mdHash[:entity] << TDClass.entity
   mdHash[:entity] << TDClass.entity

   @@mdHash = mdHash

   def test_dictionary_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'dataDictionary.json')
      assert_empty errors

   end

   def test_complete_dictionary_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'dictionary description', metadata[:description]
      refute_empty metadata[:citation]
      assert_equal 2, metadata[:subjects].length
      assert_equal 'subject one', metadata[:subjects][0]
      assert_equal 'subject two', metadata[:subjects][1]
      assert_equal 2, metadata[:recommendedUses].length
      assert_equal 'use one', metadata[:recommendedUses][0]
      assert_equal 'use two', metadata[:recommendedUses][1]
      assert_equal 2, metadata[:locales].length
      refute_empty metadata[:responsibleParty]
      assert_equal 'dictionary functional language', metadata[:dictionaryFunctionalLanguage]
      refute metadata[:includedWithDataset]
      assert_equal 2, metadata[:domains].length
      assert_equal 2, metadata[:entities].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_empty_citation

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['citation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary citation is missing'

   end

   def test_dictionary_missing_citation

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary citation is missing'

   end

   def test_dictionary_empty_subject

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['subject'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary subject is missing'

   end

   def test_dictionary_missing_subject

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('subject')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary subject is missing'

   end

   def test_dictionary_empty_responsibleParty

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['responsibleParty'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary responsible party is missing'

   end

   def test_dictionary_missing_responsibleParty

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('responsibleParty')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary responsible party is missing'

   end

   def test_dictionary_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hIn['recommendedUse'] = []
      hIn['locale'] = []
      hIn['dictionaryFormat'] = ''
      hIn['dictionaryFunctionalLanguage'] = ''
      hIn['dictionaryIncludedWithResource'] = ''
      hIn['domain'] = []
      hIn['entity'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      refute_empty metadata[:citation]
      refute_empty metadata[:subjects]
      assert_empty metadata[:recommendedUses]
      assert_empty metadata[:locales]
      refute_empty metadata[:responsibleParty]
      assert_nil metadata[:dictionaryFunctionalLanguage]
      refute metadata[:includedWithDataset]
      assert_empty metadata[:domains]
      assert_empty metadata[:entities]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('description')
      hIn.delete('recommendedUse')
      hIn.delete('locale')
      hIn.delete('dictionaryFormat')
      hIn.delete('dictionaryFunctionalLanguage')
      hIn.delete('dictionaryIncludedWithResource')
      hIn.delete('domain')
      hIn.delete('entity')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      refute_empty metadata[:citation]
      refute_empty metadata[:subjects]
      assert_empty metadata[:recommendedUses]
      assert_empty metadata[:locales]
      refute_empty metadata[:responsibleParty]
      assert_nil metadata[:dictionaryFunctionalLanguage]
      refute metadata[:includedWithDataset]
      assert_empty metadata[:domains]
      assert_empty metadata[:entities]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_deprecated_dictionaryFormat

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('dictionaryFunctionalLanguage')

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'deprecated', metadata[:dictionaryFunctionalLanguage]
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: data dictionary dictionaryFormat is deprecated, use dictionaryFunctionalLanguage'

   end

   def test_empty_dictionary_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: data dictionary object is empty'

   end

end
