# MdTranslator - minitest of
# reader / mdJson / module_taxonomicClassification

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomicClassification'

class TestReaderMdJsonTaxonomicClassification < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TaxonomicClassification
   aIn = TestReaderMdJsonParent.getJson('taxonomicClassification.json')
   @@hIn = aIn['taxonomicClassification'][0]

   # TODO reinstate after schema update
   # def test_taxClass_schema
   #
   #    hIn = Marshal::load(Marshal.dump(@@hIn))
   #    hIn = hIn['subClassification'][0]['subClassification'][0]['subClassification'][0]
   #    errors = TestReaderMdJsonParent.testSchema(hIn, 'taxonomy.json', :fragment => 'taxonomicClassification')
   #    assert_empty errors
   #
   # end

   def test_complete_taxClass_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxonomicLevel0', metadata[:taxonRank]
      assert_nil metadata[:taxonId]
      assert_equal 'taxonomicName', metadata[:taxonValue]
      assert_equal 2, metadata[:commonNames].length
      assert_equal 'commonName0', metadata[:commonNames][0]
      assert_equal 'commonName1', metadata[:commonNames][1]
      assert_equal 2, metadata[:subClasses].length
      assert_equal 'taxonomicLevel00', metadata[:subClasses][0][:taxonRank]
      assert_equal 'taxonomicSystemId00', metadata[:subClasses][0][:taxonId]
      assert_equal 'taxonomicLevel01', metadata[:subClasses][1][:taxonRank]
      assert_equal 'taxonomicLevel0000.1', metadata[:subClasses][0][:subClasses][0][:subClasses][0][:taxonRank]
      assert_equal 'taxonomicSystemId0000.1', metadata[:subClasses][0][:subClasses][0][:subClasses][0][:taxonId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxClass_empty_taxLevel

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['taxonomicLevel'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: taxonomic classification level is missing'

   end

   def test_taxClass_missing_taxLevel

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('taxonomicLevel')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification level is missing'

   end

   def test_taxClass_taxRank_deprecated

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['taxonomicRank'] = hIn['taxonomicLevel']
      hIn.delete('taxonomicLevel')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'NOTICE: mdJson reader: taxonomic classification taxonomicRank is deprecated, use taxonomicLevel'

   end

   def test_taxClass_empty_taxName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['taxonomicName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: taxonomic classification name is missing'

   end

   def test_taxClass_missing_taxName

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('taxonomicName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: taxonomic classification name is missing'

   end

   def test_taxClass_latinName_deprecated

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['latinName'] = hIn['taxonomicName']
      hIn.delete('taxonomicName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'NOTICE: mdJson reader: taxonomic classification latinName is deprecated, use taxonomicName'

   end

   def test_taxClass_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['commonName'] = []
      hIn['subClassification'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxonomicLevel0', metadata[:taxonRank]
      assert_equal 'taxonomicName', metadata[:taxonValue]
      assert_empty metadata[:commonNames]
      assert_empty metadata[:subClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxClass_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('commonName')
      hIn.delete('subClassification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxonomicLevel0', metadata[:taxonRank]
      assert_equal 'taxonomicName', metadata[:taxonValue]
      assert_empty metadata[:commonNames]
      assert_empty metadata[:subClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_taxClass_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: taxonomic classification object is empty'

   end

end
