# MdTranslator - minitest of
# reader / mdJson / module_geologicAge

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geologicAge'

class TestReaderMdJsonGeologicAge < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeologicAge
   aIn = TestReaderMdJsonParent.getJson('geologicAge.json')
   @@hIn = aIn['geologicAge'][0]

   # TODO complete after schema update
   # def test_series_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'citation.json', :fragment=>'series')
   #     assert_empty errors
   #
   # end

   def test_complete_geologicAge_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'geologic age time scale', metadata[:ageTimeScale]
      assert_equal 'geologic age estimate', metadata[:ageEstimate]
      assert_equal 'geologic age uncertainty', metadata[:ageUncertainty]
      assert_equal 'geologic age explanation', metadata[:ageExplanation]
      assert_equal 2, metadata[:ageReferences].length
      assert_equal 'geologic age reference title 1', metadata[:ageReferences][0][:title]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geologicAge_empty_timeScale

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['ageTimeScale'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: geologic age time scale is missing'

   end

   def test_geologicAge_missing_timeScale

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('ageTimeScale')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: geologic age time scale is missing'

   end

   def test_geologicAge_empty_timeEstimate

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['ageEstimate'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: geologic age age-estimate is missing'

   end

   def test_geologicAge_missing_timeEstimate

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('ageEstimate')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: geologic age age-estimate is missing'

   end


   def test_geologicAge_empty_elements
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['ageUncertainty'] = ''
      hIn['ageExplanation'] = ''
      hIn['ageReference'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:ageUncertainty]
      assert_nil metadata[:ageExplanation]
      assert_empty metadata[:ageReferences]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_geologicAge_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('ageUncertainty')
      hIn.delete('ageExplanation')
      hIn.delete('ageReference') 
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:seriesName]
      assert_nil metadata[:seriesIssue]
      assert_nil metadata[:issuePage]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_series_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: geologic age object is empty'

   end

end
