# MdTranslator - minitest of
# reader / mdJson / module_entityForeignKey

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-06 refactored for mdJson 2.0
#  Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityForeignKey'

class TestReaderMdJsonForeignKey < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityForeignKey

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.foreignKey

   @@mdHash = mdHash

   def test_entityForeignKey_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'entity.json', :fragment => 'foreignKey')
      assert_empty errors

   end

   def test_complete_FK_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'local attribute code name one', metadata[:fkLocalAttributes][0]
      assert_equal 'local attribute code name two', metadata[:fkLocalAttributes][1]
      assert_equal 'referenced entity code name', metadata[:fkReferencedEntity]
      assert_equal 'referenced attribute code name one', metadata[:fkReferencedAttributes][0]
      assert_equal 'referenced attribute code name two', metadata[:fkReferencedAttributes][1]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_FK_localAttributeCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['localAttributeCodeName'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key local attribute code name is missing: CONTEXT is testing'

   end

   def test_missing_FK_localAttributeCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('localAttributeCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key local attribute code name is missing: CONTEXT is testing'

   end

   def test_empty_FK_referencedEntityCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referencedEntityCodeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key referenced entity name is missing: CONTEXT is testing'

   end

   def test_missing_FK_referencedEntityCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referencedEntityCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key referenced entity name is missing: CONTEXT is testing'

   end

   def test_empty_FK_referencedAttributeCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['referencedAttributeCodeName'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key referenced attribute name is missing: CONTEXT is testing'
   end

   def test_missing_FK_referencedAttributeCodeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('referencedAttributeCodeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity foreign key referenced attribute name is missing: CONTEXT is testing'

   end

   def test_empty_entityForeignKey_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: data dictionary entity foreign key object is empty: CONTEXT is testing'

   end

end
