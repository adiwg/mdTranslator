# MdTranslator - minitest of forceValid parameter

# History:
#  Stan Smith 2018-03-27 original script

require 'adiwg/mdtranslator/writers/fgdc/fgdc_writer'
require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcForceValid < TestWriterFGDCParent

   # instance classes needed in script
   @@NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hContact1 = mdHash[:contact][0]
   TDClass.add_address(hContact1, ['physical'])
   TDClass.add_phone(hContact1, '222-222-2222', %w(facsimile tty other))
   TDClass.add_phone(hContact1, '333-333-3333', %w(tty voice fax))
   hContact1[:memberOfOrganization] = []
   hContact1[:memberOfOrganization] << 'CID002'
   hContact1[:electronicMailAddress] = []
   hContact1[:electronicMailAddress] = %w(name1@adiwg.org name2@adiwg.org)
   hContact1[:onlineResource] = []
   hContact1[:onlineResource] << TDClass.build_onlineResource('https://adiwg.org/1')
   hContact1[:onlineResource] << TDClass.build_onlineResource('https://adiwg.org/2')
   hContact1[:hoursOfService] = ['8-5 weekdays','10-2 Saturday']
   hContact1[:contactInstructions] = 'contact instructions'
   hContact1[:contactType] = 'contact type'

   @@mdHash = mdHash

   def test_writeValid

      # force: true; tag: true
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:name] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', validate: 'none',
         showAllTags: true, forceValid: true
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: citation originator role is missing: CONTEXT is main resource citation'

      xWriterOutput = Nokogiri::XML(hResponseObj[:writerOutput])
      xOutput = xWriterOutput.xpath('./metadata/idinfo/citation/citeinfo/origin')
      assert_equal 'missing', xOutput.text

      # force: true; tag: false
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', validate: 'none',
         showAllTags: true, forceValid: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: contact address is missing: CONTEXT is contactId CID001'

      xWriterOutput = Nokogiri::XML(hResponseObj[:writerOutput])
      xOutput = xWriterOutput.xpath('./metadata/idinfo/ptcontac/cntinfo/cntaddr')
      assert_empty xOutput.text

      # force: false; tag: true
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:name] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', validate: 'none',
         showAllTags: true, forceValid: false
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: citation originator role is missing: CONTEXT is main resource citation'

      xWriterOutput = Nokogiri::XML(hResponseObj[:writerOutput])
      xOutput = xWriterOutput.xpath('./metadata/idinfo/citation/citeinfo/origin')
      assert_empty xOutput.text

      # force: false; tag: false
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', validate: 'none',
         showAllTags: true, forceValid: false
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: contact address is missing: CONTEXT is contactId CID001'

      xWriterOutput = Nokogiri::XML(hResponseObj[:writerOutput])
      xOutput = xWriterOutput.xpath('./metadata/idinfo/ptcontac/cntinfo/cntaddr')
      assert_empty xOutput.text

   end

end
