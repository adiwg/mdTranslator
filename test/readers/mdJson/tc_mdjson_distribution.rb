# MdTranslator - minitest of
# reader / mdJson / module_distribution

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_distribution'

class TestReaderMdJsonDistribution < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Distribution
   aIn = TestReaderMdJsonParent.getJson('distribution.json')
   @@hIn = aIn['resourceDistribution'][0]

   # TODO reinstate after schema update
   # def test_distribution_schema
   #
   #    errors = TestReaderMdJsonParent.testSchema(@@hIn, 'distribution.json')
   #    assert_empty errors
   #
   # end

   def test_complete_distribution_object

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'description', metadata[:description]
      assert_equal 'distribution liability statement', metadata[:liabilityStatement]
      assert_equal 2, metadata[:distributor].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_distribution_empty_required

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hIn['distributor'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson distribution must have description or distributor'

   end

   def test_distribution_missing_required

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hIn.delete('distributor')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson distribution must have description or distributor'

   end

   def test_distribution_empty_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['liabilityStatement'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:liabilityStatement]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_distribution_missing_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('liabilityStatement')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:liabilityStatement]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_distribution_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: distribution object is empty'

   end

end
