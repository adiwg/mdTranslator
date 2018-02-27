# MdTranslator - minitest of
# reader / mdJson / module_date

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_date'

class TestReaderMdJsonDate < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Date
   aIn = TestReaderMdJsonParent.getJson('date.json')
   @@hIn = aIn['date'][0]

   def test_complete_date_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)
      assert_kind_of Date, metadata[:date]
      assert_equal 'YMD', metadata[:dateResolution]
      assert_equal 'dateType', metadata[:dateType]
      assert_equal 'description', metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_date_invalid

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['date'] = '2018-02-30'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson date string is invalid'

   end

   def test_empty_date_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['date'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson date string is missing'

   end

   def test_missing_date_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('date')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson date string is missing'

   end

   def test_empty_dateType_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dateType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson date type is missing'

   end

   def test_missing_dateType_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dateType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson date type is missing'

   end

   def test_empty_description_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_kind_of Date, metadata[:date]
      assert_equal 'YMD', metadata[:dateResolution]
      assert_equal 'dateType', metadata[:dateType]
      assert_nil metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_description_element

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_kind_of Date, metadata[:date]
      assert_equal 'YMD', metadata[:dateResolution]
      assert_equal 'dateType', metadata[:dateType]
      assert_nil metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_date_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: date object is empty'

   end

end