require 'active_record'
require 'rspec'

require_relative '../app/models/person'

database_configuration = YAML::load(File.open('config/database.yml'))
configuration = database_configuration['test']
ActiveRecord::Base.establish_connection(configuration)

describe Person do
  it 'has a given name' do
    aPerson = Person.new
    aPerson.given_name = "John"
    expect(aPerson.given_name).to eq 'John'
  end

  it 'has a given name' do
    aPerson = Person.new
    aPerson.family_name = "Doe"
    expect(aPerson.family_name).to eq 'Doe'
  end

  it 'has mother' do
    mom = Person.new
    mom.given_name = 'Mary'
    mom.save
    son = Person.new
    son.given_name = "John"
    son.mother = mom
    son.save
    expect(son.mother).to eq(mom)
  end

  it 'has father' do
    dad = Person.new
    dad.given_name = 'James'
    dad.save
    son = Person.new
    son.given_name = "John"
    son.father = dad
    son.save
    expect(son.father).to eq(dad)
  end

  it 'has grandfather' do
    gramps = Person.new
    gramps.given_name = 'Jose'
    gramps.save
    dad = Person.new
    dad.given_name = 'James'
    dad.father = gramps
    dad.save
    son = Person.new
    son.given_name = "John"
    son.father = dad
    son.save
    expect(son.father.father).to eq(gramps)
  end

  it 'has grandmother' do
    granny = Person.new
    granny.given_name = 'Maria'
    granny.save
    mom = Person.new
    mom.given_name = 'Mary'
    mom.mother = granny
    mom.save
    son = Person.new
    son.given_name = "John"
    son.mother = mom
    son.save
    expect(son.mother.mother).to eq(granny)
  end

  it 'has ancestors' do
    granny = Person.new
    granny.given_name = 'Maria'
    granny.save
    gramps = Person.new
    gramps.given_name = 'Jose'
    gramps.save
    mom = Person.new
    mom.given_name = 'Mary'
    mom.mother = granny
    mom.save
    dad = Person.new
    dad.given_name = 'James'
    dad.father = gramps
    dad.save
    son = Person.new
    son.given_name = "John"
    son.father = dad
    son.mother = mom
    son.save
    expect(son.maleAncestors + son.femaleAncestors).to match_array([dad, gramps, mom, granny])
  end

end
