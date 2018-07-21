# mdJson 2.0 writer tests - constraint

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonConstraint < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:constraint][0] = TDClass.constraint

   @@mdHash = mdHash

   def test_schema_constraint

      hTest = @@mdHash[:metadata][:resourceInfo][:constraint][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'constraint.json')
      assert_empty errors

   end

   def test_use_constraint

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['constraint']
      expect[0].delete('legal')
      expect[0].delete('security')
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

   def test_legal_constraint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][0][:type] = 'legal'

      TDClass.removeEmptyObjects(hIn)

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hIn.to_json)
      expect = expect['metadata']['resourceInfo']['constraint']
      expect[0].delete('security')
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

   def test_security_constraint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][0][:type] = 'security'

      TDClass.removeEmptyObjects(hIn)

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(hIn.to_json)
      expect = expect['metadata']['resourceInfo']['constraint']
      expect[0].delete('legal')
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
