# MdTranslator - minitest of
# reader / mdJson / module_maintenance

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_maintenance'

class TestReaderMdJsonMaintenance < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Maintenance

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_maintenance
   mdHash[:date] << TDClass.build_date('2018-05-25','lastUpdate')
   mdHash[:date] << TDClass.build_date('2019-04','nextUpdate')
   mdHash[:scope] << TDClass.scope
   mdHash[:scope] << TDClass.scope
   mdHash[:contact] << TDClass.build_responsibleParty('custodian',['CID003'])
   mdHash[:contact] << TDClass.build_responsibleParty('rightHolder',['CID004'])

   @@mdHash = mdHash

   def test_maintenance_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'maintInfo.json')
      assert_empty errors

   end

   def test_complete_maintenance_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'maintenance frequency', metadata[:frequency]
      assert_equal 2, metadata[:dates].length
      assert_equal 2, metadata[:scopes].length
      assert_equal 2, metadata[:notes].length
      assert_equal 2, metadata[:contacts].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_maintenance_empty_frequency

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['frequency'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: maintenance frequency is missing: CONTEXT is testing'

   end

   def test_maintenance_missing_frequency

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('frequency')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: maintenance frequency is missing: CONTEXT is testing'

   end

   def test_maintenance_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['date'] = []
      hIn['scope'] = []
      hIn['note'] = []
      hIn['contact'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'maintenance frequency', metadata[:frequency]
      assert_empty metadata[:dates]
      assert_empty metadata[:scopes]
      assert_empty metadata[:notes]
      assert_empty metadata[:contacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_maintenance_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('date')
      hIn.delete('scope')
      hIn.delete('note')
      hIn.delete('contact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'maintenance frequency', metadata[:frequency]
      assert_empty metadata[:dates]
      assert_empty metadata[:scopes]
      assert_empty metadata[:notes]
      assert_empty metadata[:contacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_maintenance_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: maintenance object is empty: CONTEXT is testing'

   end

end
