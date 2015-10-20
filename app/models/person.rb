require 'active_record'

class Person < ActiveRecord::Base

  belongs_to :mother, :class_name => 'Person'
  belongs_to :father, :class_name => 'Person'

  def maleAncestors
    anc = []
    aPerson = self
    while !aPerson.father.nil? do
      anc << aPerson.father
      aPerson = aPerson.father
    end
    anc
  end

    def femaleAncestors
      anc = []
      aPerson = self
      while !aPerson.mother.nil? do
        anc << aPerson.mother
        aPerson = aPerson.mother
      end
      anc
    end
end
