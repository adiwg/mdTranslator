# MdTranslator - minitest of
# reader / mdJson / module_onlineResource

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_onlineResource'

class TestReaderMdJsonOnlineResource < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OnlineResource

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_onlineResource('https://adiwg.org/1')

   @@mdHash = mdHash

   def test_onlineResource_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'onlineResource.json')
      assert_empty errors

   end

   def test_complete_onlineResource_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'https://adiwg.org/1', metadata[:olResURI]
      assert_equal 'online resource name', metadata[:olResName]
      assert_equal 'online resource description', metadata[:olResDesc]
      assert_equal 'online resource function', metadata[:olResFunction]
      assert_equal 'application profile', metadata[:olResApplicationProfile]
      assert_equal 'protocol', metadata[:olResProtocol]
      assert_equal 'protocol request', metadata[:olResProtocolRequest]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]


   end

   def test_empty_onlineResource_uri

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['uri'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: online resource URI is missing: CONTEXT is testing'

   end

   def test_missing_onlineResource_uri

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('uri')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: online resource URI is missing: CONTEXT is testing'

   end

   def test_empty_onlineResource_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['name'] = ''
      hIn['description'] = ''
      hIn['function'] = ''
      hIn['applicationProfile'] = ''
      hIn['protocol'] = ''
      hIn['protocolRequest'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:olResName]
      assert_nil metadata[:olResDesc]
      assert_nil metadata[:olResFunction]
      assert_nil metadata[:olResApplicationProfile]
      assert_nil metadata[:olResProtocol]
      assert_nil metadata[:olResProtocolRequest]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_onlineResource_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('name')
      hIn.delete('description')
      hIn.delete('function')
      hIn.delete('applicationProfile')
      hIn.delete('protocol')
      hIn.delete('protocolRequest')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:olResName]
      assert_nil metadata[:olResDesc]
      assert_nil metadata[:olResFunction]
      assert_nil metadata[:olResApplicationProfile]
      assert_nil metadata[:olResProtocol]
      assert_nil metadata[:olResProtocolRequest]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_onlineResource_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: online resource object is empty: CONTEXT is testing'

   end

end
