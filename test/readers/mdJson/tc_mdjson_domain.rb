# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-11-01 added domainReference
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-07 refactored for mdJson 2.0
#  Stan Smith 2015-06-22 refactored setup after removal of globals
#  Stan Smith 2015-01-20 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_domain'

class TestReaderMdJsonDomain < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Domain

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.dictionaryDomain
   mdHash[:domainItem] << TDClass.domainItem
   mdHash[:domainItem] << TDClass.domainItem

   @@mdHash = mdHash

   def test_domain_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'domain.json')
      assert_empty errors

   end

   def test_complete_domain_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'DOM001', metadata[:domainId]
      assert_equal 'domain common name', metadata[:domainName]
      assert_equal 'domain code name', metadata[:domainCode]
      assert_equal 'domain description', metadata[:domainDescription]
      refute_empty metadata[:domainReference]
      assert_equal 'domain reference title', metadata[:domainReference][:title]
      assert_equal 2, metadata[:domainItems].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_domainId

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['domainId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary domain ID is missing'

   end

   def test_missing_domainId

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('domainId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary domain ID is missing'

   end

   def test_empty_domain_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary domain code is missing: CONTEXT is domain ID DOM001'

   end

   def test_missing_domain_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary domain code is missing: CONTEXT is domain ID DOM001'

   end

   def test_empty_domain_description

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['description'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary domain description is missing: CONTEXT is domain ID DOM001'

   end

   def test_missing_domain_description

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary domain description is missing: CONTEXT is domain ID DOM001'

   end

   def test_empty_domain_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['commonName'] = ''
      hIn['domainReference'] = {}
      hIn['domainItems'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:domainName]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_domain_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('commonName')
      hIn.delete('domainReference')
      hIn.delete('domainItems')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:domainName]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_domain_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: data dictionary domain object is empty'

   end

end
