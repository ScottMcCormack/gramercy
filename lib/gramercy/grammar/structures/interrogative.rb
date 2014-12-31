module Gramercy
  module Grammar
    module Structures

      # What is your favorite movie?
      class SimpleQuestionWithInterrogative

        include SentenceInitializer

        def conforms?
          begins_with_interrogative?
        end

        def subject
        end

        def interrogative
          interrogatives.first
        end

        def predicate
          (split_text[(verb_position + 1)..-1]).join(" ")
        end

        private

        def begins_with_interrogative?
          return if interrogatives.empty?
          split_text.index(interrogatives.first) <= split_text.size / 2
        end

        def interrogatives
          @interrogatives ||= (split_text & PartOfSpeech::Interrogative.base_forms).compact
        end

      end

      # Is the movie scary?
      class SimpleQuestion

        include SentenceInitializer

        def conforms?
          self.verb_position == 0
        end

        def interrogative
        end

        def subject
          noun_phrases[0..-2].reject{|w| all_adjectives.include? w}.first
        end

        def predicate
          noun_phrases.last
        end

        def noun_phrases
          @noun_phrases ||= split_text[verb_position + 1..-1].reject{|w| all_articles.include? w}
        end

        private

        def all_articles
          @all_articles ||= PartOfSpeech::Article.base_forms
        end

        def all_adjectives
          @all_adjectives ||= PartOfSpeech::Adjective.base_forms
        end

      end

    end
  end
end