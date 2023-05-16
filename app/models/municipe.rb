class Municipe < ApplicationRecord
  has_one_attached :picture
  has_one :address
  accepts_nested_attributes_for :address

  validates :name, :birth, :cpf, :cns, :email, :phone, presence: true
  validate :cpf_is_valid?
  validate :email_is_valid?
  validate :cns_is_valid?
  validate :date_is_valid?

  after_save -> { MunicipeMailer.with(municipe: self).hello.deliver_later } # send email
  after_save -> { Twilio::TwilioJob.set(wait: 10.seconds).perform_later(self) } # send SMS

  scope :filter_by, lambda { |search|
    return all if search.blank?

    joins(:address).where(ilike(:name, search))
                   .or(where(ilike(:cpf, search)))
                   .or(where(ilike(:cns, search)))
                   .or(where(ilike(:email, search)))
                   .or(where(ilike(:phone, search)))
                   .or(where(Address.ilike(:cep, search)))
                   .or(where(Address.ilike(:city, search)))
                   .or(where(Address.ilike(:state, search)))
                   .or(where(Address.ilike(:neighborhood, search)))
                   .or(where(Address.ilike(:street, search)))
  }

  def full_address
    return unless address.present?

    "#{address.city}, #{address.street} #{address.number}, #{address.neighborhood}, #{address.state}"
  end

  private

  def cpf_is_valid?
    return errors.add(:cpf, 'CPF não é válido') unless CPF.valid?(cpf)
  end

  def email_is_valid?
    return errors.add(:email, 'E-mail não é válido') unless email =~ /[.\w]+@\w+\.(\w\w\w\.\w\w|\w\w\w)/
  end

  def cns_is_valid?
    return errors.add(:cns, 'CNS não é válido') unless Cns::Cns.valid?(cns)
  end

  def date_is_valid?
    return errors.add(:birth, 'Aniversário não é válido') unless Date.today.year - birth.year in (0..130)
  end

  def self.ilike(attribute, value)
    value = value.split(' ') unless value.is_a? Array

    arel_result = arel_table[attribute.to_sym].matches("%#{value.first}%")
    (1...value.size).each do |index|
      arel_result = arel_result.or(arel_table[attribute.to_sym].matches("%#{value[index]}%"))
    end

    arel_result
  end
end
