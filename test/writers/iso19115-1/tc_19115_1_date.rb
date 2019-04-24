# MdTranslator - minitest of
# writers / iso19115_1 / class_date

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Date < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   aDates = []
   aDates << TDClass.build_date('2018')
   aDates << TDClass.build_date('2018-04')
   aDates << TDClass.build_date('2018-04-19')
   aDates << TDClass.build_date('2018-04-19T12')
   aDates << TDClass.build_date('2018-04-19T12:49')
   aDates << TDClass.build_date('2018-04-19T12:49:17')
   aDates << TDClass.build_date('2018-04-19T12:49:17.123')
   aDates << TDClass.build_date('2018-04-19T12Z')
   aDates << TDClass.build_date('2018-04-19T12:49Z')
   aDates << TDClass.build_date('2018-04-19T12:49:17Z')
   aDates << TDClass.build_date('2018-04-19T12:49:17.123Z')
   aDates << TDClass.build_date('2018-04-19T12-09')
   aDates << TDClass.build_date('2018-04-19T12:49-09')
   aDates << TDClass.build_date('2018-04-19T12:49:17-09')
   aDates << TDClass.build_date('2018-04-19T12:49:17.123-09')
   aDates << TDClass.build_date('2018-04-19T12+06:15')
   aDates << TDClass.build_date('2018-04-19T12:49+06:15')
   aDates << TDClass.build_date('2018-04-19T12:49:17+06:15')
   aDates << TDClass.build_date('2018-04-19T12:49:17.123+06:15')

   mdHash[:metadata][:resourceInfo][:citation][:date] = aDates

   @@mdHash = mdHash

   def test_date_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      xFile = TestWriter191151Parent.get_xml('19115_1_date')
      axExpect = xFile.xpath('//cit:date')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19115_1', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//cit:date')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze(' '), axGot[i+3].to_s.squeeze(' ')
      }

   end

end
