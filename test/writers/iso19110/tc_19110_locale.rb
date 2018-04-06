# MdTranslator - minitest of
# writers / iso19110 / class_locale

# History:
#  Stan Smith 2018-04-02 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-31 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110Locale < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_locale_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:locale] << TDClass.locale
      hIn[:dataDictionary][0][:locale] << TDClass.build_locale('swe', 'UTF-16', nil)

      hReturn = TestWriter19110Parent.get_complete(hIn, '19110_locale',
                                                   '//gmx:locale', '//gmx:locale')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
