# MdTranslator - minitest of
# reader / mdJson / module_associatedResource

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2014-12-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_associatedResource'

class TestReaderMdJsonAssociatedResource < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AssociatedResource
   aIn = TestReaderMdJsonParent.getJson('associatedResource.json')
   @@hIn = aIn['associatedResource'][0]

   def test_associatedResource_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'associatedResource.json')
      assert_empty errors

   end

   def test_complete_associatedResource

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:resourceTypes].length
      assert_equal 'associationType', metadata[:associationType]
      assert_equal 'initiativeType', metadata[:initiativeType]
      refute_empty metadata[:resourceCitation]
      refute_empty metadata[:metadataCitation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_associatedResource_empty_resourceType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['resourceType'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource resource type is missing'

   end

   def test_associatedResource_missing_resourceType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('resourceType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      refute_empty hResponse[:readerExecutionMessages]
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource resource type is missing'

   end

   def test_associatedResource_empty_associationType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['associationType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource association type is missing'

   end

   def test_associatedResource_missing_associationType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('associationType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource association type is missing'

   end

   def test_associatedResource_empty_citations

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['resourceCitation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource citation is missing'

   end

   def test_associatedResource_missing_citations

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('resourceCitation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: associated resource citation is missing'

   end

   def test_associatedResource_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['initiativeType'] = ''
      hIn['metadataCitation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:resourceTypes]
      assert_equal 'associationType', metadata[:associationType]
      assert_nil metadata[:initiativeType]
      refute_empty metadata[:resourceCitation]
      assert_empty metadata[:metadataCitation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_associatedResource_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('initiativeType')
      hIn.delete('metadataCitation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:resourceTypes]
      assert_equal 'associationType', metadata[:associationType]
      assert_nil metadata[:initiativeType]
      refute_empty metadata[:resourceCitation]
      assert_empty metadata[:metadataCitation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_associatedResource_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: mdJson reader: associated resource object is empty'

   end

end
