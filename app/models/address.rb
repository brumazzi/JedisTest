class Address < ApplicationRecord
  belongs_to :municipe

  validates :cep, :city, :state, :neighborhood, :street, :number, presence: true
  validate :cep_is_valid?

  def self.ilike(attribute, value)
    value = value.split(' ') unless value.is_a? Array

    arel_result = arel_table[attribute.to_sym].matches("%#{value.first}%")
    (1...value.size).each do |index|
      arel_result = arel_result.or(arel_table[attribute.to_sym].matches("%#{value[index]}%"))
    end

    arel_result
  end

  private

  def cep_is_valid?
    return errors.add(:cep, 'CEP não é válido') unless cep =~ /(\d{5}-\d{3}|\d{8})/
  end
end
