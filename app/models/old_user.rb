# frozen_string_literal: true

class OldUser < OldRecord
  self.table_name = :users

  has_many :memberships, class_name: 'OldMembership'

  def to_new
    puts "User #{id}"

    g = male.zero? ? :female : :male
    t = is_teacher == 1
    s = inactive == 1 ? 0 : 1

    Person.create! id: id, name: name, lastname: lastname, dni: dni,
                   cellphone: cellphone, alt_phone: alt_phone, birthday: birthday,
                   address: address, gender: g, email: email, is_teacher: t,
                   comments: comments, facebook_id: facebook_uid, age: age, status: s,
                   family_group_id: family
  end
end
