# MdTranslator - minitest of
# reader / mdJson / module_dataDictionary

# History:
#  Stan Smith 2017-11-09 add dictionary description
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_dataDictionary'

class TestReaderMdJsonDataDictionary < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::DataDictionary
   aIn = TestReaderMdJsonParent.getJson('dictionary.json')
   @@hIn = aIn['dataDictionary'][0]

   def test_dictionary_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'dataDictionary.json')
      assert_empty errors

   end

   def test_complete_dictionary_object

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'data dictionary description', metadata[:description]
      refute_empty metadata[:citation]
      assert_equal 2, metadata[:subjects].length
      assert_equal 'subject0', metadata[:subjects][0]
      assert_equal 'subject1', metadata[:subjects][1]
      assert_equal 2, metadata[:recommendedUses].length
      assert_equal 'use0', metadata[:recommendedUses][0]
      assert_equal 'use1', metadata[:recommendedUses][1]
      assert_equal 2, metadata[:locales].length
      refute_empty metadata[:responsibleParty]
      assert_equal 'functional language', metadata[:dictionaryFunctionalLanguage]
      assert metadata[:includedWithDataset]
      assert_equal 2, metadata[:domains].length
      assert_equal 2, metadata[:entities].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_empty_citation

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['citation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_missing_citation

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_empty_subject

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['subject'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_missing_subject

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('subject')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_empty_responsibleParty

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['responsibleParty'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_missing_responsibleParty

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('responsibleParty')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_dictionary_empty_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
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

   def test_deprecated_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))

      hIn.delete('dictionaryFunctionalLanguage')

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)


      refute_empty metadata[:responsibleParty]

      assert_equal 'deprecated', metadata[:dictionaryFunctionalLanguage]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_dictionary_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
