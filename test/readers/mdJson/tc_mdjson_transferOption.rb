# MdTranslator - minitest of
# reader / mdJson / module_transferOption

# History:
#  Stan Smith 2018-06-27 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_transferOption'

class TestReaderMdJsonTransferOption < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TransferOption

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_transferOption_full

   @@mdHash = mdHash

   def test_transferOption_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'transferOption.json')
      assert_empty errors

   end

   def test_complete_transferOption_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'MB', metadata[:unitsOfDistribution]
      assert_equal 999, metadata[:transferSize]
      assert_equal 2, metadata[:onlineOptions].length
      assert_equal 2, metadata[:offlineOptions].length
      refute_empty metadata[:transferFrequency]
      assert_equal 2, metadata[:distributionFormats].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_transferOption_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['transferSize'] = ''
      hIn['unitsOfDistribution'] = ''
      hIn['transferFrequency'] = {}
      hIn['distributionFormat'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:unitsOfDistribution]
      assert_nil metadata[:transferSize]
      refute_empty metadata[:onlineOptions]
      refute_empty metadata[:offlineOptions]
      assert_empty metadata[:transferFrequency]
      assert_empty metadata[:distributionFormats]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_transferOption_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('unitsOfDistribution')
      hIn.delete('transferSize')
      hIn.delete('transferFrequency')
      hIn.delete('distributionFormat')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:unitsOfDistribution]
      assert_nil metadata[:transferSize]
      refute_empty metadata[:onlineOptions]
      refute_empty metadata[:offlineOptions]
      assert_empty metadata[:transferFrequency]
      assert_empty metadata[:distributionFormats]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_transferOption_empty_options

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['onlineOption'] = []
      hIn['offlineOption'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: transfer option did not provide an online or offline option: CONTEXT is testing'

   end

   def test_transferOption_missing_options

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('onlineOption')
      hIn.delete('offlineOption')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
          'WARNING: mdJson reader: transfer option did not provide an online or offline option: CONTEXT is testing'

   end

   def test_empty_transferOption_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: transfer option object is empty: CONTEXT is testing'

   end

end
