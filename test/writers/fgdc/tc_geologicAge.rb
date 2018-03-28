# MdTranslator - minitest of
# writers / fgdc / class_geologicAge

# History:
#  Stan Smith 2017-11-24 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcGeologicAge < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new
   
   # get expected results
   xExpect = TestWriterFGDCParent.get_xml('geologicAgeResults')
   @@axExpect = xExpect.xpath('//timeperd')

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTimePeriod = mdHash[:metadata][:resourceInfo][:timePeriod]
   hTimePeriod.delete(:startDateTime)
   hTimePeriod[:startGeologicAge] = TDClass.build_geologicAge
   hTimePeriod[:startGeologicAge][:ageReference] << TDClass.build_citation('start geologic age reference one', 'CID001')
   hTimePeriod[:startGeologicAge][:ageReference] << TDClass.build_citation('start geologic age reference two', 'CID001')
   hTimePeriod[:endGeologicAge] = TDClass.build_geologicAge
   hTimePeriod[:endGeologicAge][:ageReference] << TDClass.build_citation('end geologic age reference one', 'CID001')

   @@mdHash = mdHash

   def test_geologicAge_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'geologicAge', './metadata/idinfo/timeperd')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_geologicAge_missing_elements

      expect = @@axExpect[0].to_s.squeeze(' ')

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageReference)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageReference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xGot.xpath('./metadata/idinfo/timeperd').to_s.squeeze(' ')

      assert_equal expect, got

   end

   def test_geologicAge_single_age

      # start age only
      expect = @@axExpect[1].to_s.squeeze(' ')

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageReference)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageReference)
      hIn[:metadata][:resourceInfo][:timePeriod].delete(:endGeologicAge)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xGot.xpath('./metadata/idinfo/timeperd').to_s.squeeze(' ')

      assert_equal expect, got

      # end age only
      expect = @@axExpect[2].to_s.squeeze(' ')

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:startGeologicAge].delete(:ageReference)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageUncertainty)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageExplanation)
      hIn[:metadata][:resourceInfo][:timePeriod][:endGeologicAge].delete(:ageReference)
      hIn[:metadata][:resourceInfo][:timePeriod].delete(:startGeologicAge)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xGot = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xGot.xpath('./metadata/idinfo/timeperd').to_s.squeeze(' ')

      assert_equal expect, got

   end

end
