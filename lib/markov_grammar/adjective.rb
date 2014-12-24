module MarkovGrammar
  class Adjective

    include Mongoid::Document
    include Grammar::Stems
    include Behavior::Agrees
    include Behavior::CanBeSampled
    include Disposition::HasContext
    include Disposition::HasPositivity
    include Disposition::HasGender

    validates_uniqueness_of :base_form

    field :base_form
    field :is_physical, type: Boolean, default: false

    def self.base_forms
      all.map(&:base_form)
    end

    def self.pair_with_noun(word, word_form, characteristics=[])
      agreeing_with(word, characteristics).sample.in_form_with_noun(word_form)
    end

    def in_form_with_noun(noun_in_form)
      "#{self.base_form} #{noun_in_form}"
    end

  end
end