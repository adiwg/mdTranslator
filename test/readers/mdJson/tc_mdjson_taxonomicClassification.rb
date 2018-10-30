# MdTranslator - minitest of
# reader / mdJson / module_taxonomicClassification

# History:
#  Stan Smith 2018-06-25 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomicClassification'

class TestReaderMdJsonTaxonomicClassification < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TaxonomicClassification

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_taxonomyClassification_full

   @@mdHash = mdHash

   def test_taxClass_schema

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = hIn[:subClassification][0]
      hIn[:latinName] = 'deprecated'
      hIn[:taxonomicRank] = 'deprecated'
      errors = TestReaderMdJsonParent.testSchema(hIn, 'taxonomy.json', :fragment => 'taxonomicClassification')
      assert_empty errors

   end

   def test_complete_taxClass_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxon rank', metadata[:taxonRank]
      assert_equal 'taxon id', metadata[:taxonId]
      assert_equal 'taxon name', metadata[:taxonValue]
      assert_equal 2, metadata[:commonNames].length
      assert_equal 'common one', metadata[:commonNames][0]
      assert_equal 'common two', metadata[:commonNames][1]
      assert_equal 1, metadata[:subClasses].length
      assert_equal 'level two', metadata[:subClasses][0][:taxonRank]
      assert_equal 'name two', metadata[:subClasses][0][:taxonValue]
      assert_equal 1, metadata[:subClasses][0][:subClasses].length
      assert_equal 2, metadata[:subClasses][0][:subClasses][0][:subClasses].length
      assert_equal 1, metadata[:subClasses][0][:subClasses][0][:subClasses][0][:subClasses].length
      assert_equal 1, metadata[:subClasses][0][:subClasses][0][:subClasses][1][:subClasses].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxClass_empty_taxLevel

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['taxonomicLevel'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification level is missing'

   end

   def test_taxClass_missing_taxLevel

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('taxonomicLevel')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification level is missing'

   end

   def test_taxClass_taxRank_deprecated

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['taxonomicName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification name is missing'

   end

   def test_taxClass_missing_taxName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('taxonomicName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: taxonomic classification name is missing'

   end

   def test_taxClass_latinName_deprecated

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['commonName'] = []
      hIn['subClassification'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxon rank', metadata[:taxonRank]
      assert_equal 'taxon name', metadata[:taxonValue]
      assert_empty metadata[:commonNames]
      assert_empty metadata[:subClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxClass_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('commonName')
      hIn.delete('subClassification')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'taxon rank', metadata[:taxonRank]
      assert_equal 'taxon name', metadata[:taxonValue]
      assert_empty metadata[:commonNames]
      assert_empty metadata[:subClasses]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_taxClass_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: taxonomic classification object is empty'

   end

end
