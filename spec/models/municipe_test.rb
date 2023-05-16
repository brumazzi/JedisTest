require 'rails_helper'

RSpec.describe Municipe, type: :model do
  subject do
    described_class.new(
      name: 'My Name',
      cpf: '58717168490',
      cns: '187329617340002',
      email: 'mail@mail.com',
      phone: '16999999999',
      birth: Date.today
    )
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a cpf' do
    subject.cpf = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a phone' do
    subject.phone = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with invalid cpf' do
    subject.cpf = '99999999999'
    expect(subject).to_not be_valid
  end

  it 'is not valid with invalid cns' do
    subject.cns = '999999999999999'
    expect(subject).to_not be_valid
  end

  it 'is not valid with invalid birth' do
    subject.birth = Date.today + 2.years
    expect(subject).to_not be_valid
  end
end