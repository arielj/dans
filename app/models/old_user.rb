class OldUser < OldRecord
  self.table_name = :users

  def to_new
    g = male == 0 ? :female : :male
    t = is_teacher == 1
    s = inactive == 1 ? 0 : 1

    Person.create id: id, name: name, lastname: lastname, dni: dni,
      cellphone: cellphone, alt_phone: alt_phone, birthday: birthday,
      address: address, gender: g, email: email, is_teacher: t,
      comments: comments, facebook_id: facebook_uid, age: age, status: s,
      family_group_id: family
  end
end
