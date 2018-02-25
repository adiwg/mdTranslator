# MdTranslator - minitest of
# reader / mdJson / module_domain

# History:
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
   aIn = TestReaderMdJsonParent.getJson('domain.json')
   @@hIn = aIn['domain'][0]

   def test_domain_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'domain.json')
      assert_empty errors

   end

   def test_complete_domain_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'domainId', metadata[:domainId]
      assert_equal 'commonName', metadata[:domainName]
      assert_equal 'codeName', metadata[:domainCode]
      assert_equal 'description', metadata[:domainDescription]
      refute_empty metadata[:domainReference]
      assert_equal 'domain reference title', metadata[:domainReference][:title]
      assert_equal 2, metadata[:domainItems].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_domainId

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['domainId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain ID is missing'

   end

   def test_missing_domainId

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('domainId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain ID is missing'

   end

   def test_empty_domain_codeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain code is missing'

   end

   def test_missing_domain_codeName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain code is missing'

   end

   def test_empty_domain_description

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain description is missing'

   end

   def test_missing_domain_description

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson data dictionary domain description is missing'

   end

   def test_empty_domain_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson data dictionary domain object is empty'

   end

end
