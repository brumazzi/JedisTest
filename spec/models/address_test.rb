require 'rails_helper'

RSpec.describe Address, type: :model do
  subject do
    described_class.new(
      cep: '88137100',
      street: 'Alguma Rua Qualquer',
      neighborhood: 'Nevasca',
      city: 'Florianopulis',
      state: 'SC',
      number: 32,
      municipe: Municipe.new
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a municipe' do
    subject.municipe = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a cep' do
    subject.cep = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a street' do
    subject.street = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a neighborhood' do
    subject.neighborhood = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a city' do
    subject.city = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a state' do
    subject.state = nil
    expect(subject).to_not be_valid
  end
end