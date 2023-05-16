require 'rails_helper'

RSpec.describe MunicipesController, type: :controller do
  subject do
    Municipe.new(
      name: 'name',
      cpf: '58717168490',
      cns: '187329617340002',
      email: 'test@test.com',
      phone: '16999999999',
      birth: Date.today - 17.years
    )
  end

  it 'should be able to create a municipe' do
    name = 'My Name'

    post :create, params: {
      municipe: {
        name: name,
        cpf: '58717168490',
        cns: '187329617340002',
        email: 'test@test.com',
        phone: '16999999999',
        birth: Date.today - 32.years
      }
    }
    municipe = Municipe.first
    expect(municipe.name).to be == name
    expect(response).to redirect_to(edit_municipe_path(municipe.id))
  end

  it 'should be able to update a municipe' do
    subject.save
    patch :update, params: {
      id: subject.id,
      municipe: {
        name: 'New Name'
      }
    }

    municipe = Municipe.first
    expect(municipe.name).to be == 'New Name'
    expect(response).to redirect_to(edit_municipe_path(municipe.id))
  end
end