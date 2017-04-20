# MdTranslator - minitest of
# reader / mdJson / module_locale

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 20116-10-05 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_locale'

class TestReaderMdJsonLocale < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Locale
    aIn = TestReaderMdJsonParent.getJson('locale.json')
    @@hIn = aIn['locale'][0]

    def test_locale_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'locale.json')
        assert_empty errors

    end

    def test_complete_locale_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'language1', metadata[:languageCode]
        assert_equal 'country1', metadata[:countryCode]
        assert_equal 'characterSet1', metadata[:characterEncoding]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_language_code

        # empty language code should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['language'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_language_code

        # missing language code should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('language')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_character_code

        # empty characterSet code should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['characterSet'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_character_code

        # missing characterSet code should return empty object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('characterSet')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_country_code

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['country'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'language1', metadata[:languageCode]
        assert_nil metadata[:countryCode]
        assert_equal 'characterSet1', metadata[:characterEncoding]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_country_code

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('country')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'language1', metadata[:languageCode]
        assert_nil metadata[:countryCode]
        assert_equal 'characterSet1', metadata[:characterEncoding]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_locale_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
