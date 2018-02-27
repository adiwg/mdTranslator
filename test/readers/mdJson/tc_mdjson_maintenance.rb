# MdTranslator - minitest of
# reader / mdJson / module_maintenance

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_maintenance'

class TestReaderMdJsonMaintenance < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Maintenance
   aIn = TestReaderMdJsonParent.getJson('maintenance.json')
   @@hIn = aIn['resourceMaintenance'][0]

   def test_maintenance_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'maintInfo.json')
      assert_empty errors

   end

   def test_complete_maintenance_object

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'frequency', metadata[:frequency]
      assert_equal 2, metadata[:dates].length
      assert_equal 2, metadata[:scopes].length
      assert_equal 2, metadata[:notes].length
      assert_equal 2, metadata[:contacts].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_maintenance_empty_frequency

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['frequency'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson resource maintenance frequency is missing'

   end

   def test_maintenance_missing_frequency

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('frequency')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson resource maintenance frequency is missing'

   end

   def test_maintenance_empty_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['date'] = []
      hIn['scope'] = []
      hIn['note'] = []
      hIn['contact'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'frequency', metadata[:frequency]
      assert_empty metadata[:dates]
      assert_empty metadata[:scopes]
      assert_empty metadata[:notes]
      assert_empty metadata[:contacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_maintenance_missing_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('date')
      hIn.delete('scope')
      hIn.delete('note')
      hIn.delete('contact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'frequency', metadata[:frequency]
      assert_empty metadata[:dates]
      assert_empty metadata[:scopes]
      assert_empty metadata[:notes]
      assert_empty metadata[:contacts]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_maintenance_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: resource maintenance object is empty'

   end

end
