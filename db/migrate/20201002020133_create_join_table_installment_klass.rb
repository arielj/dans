class CreateJoinTableInstallmentKlass < ActiveRecord::Migration[6.0]
  def change
    create_join_table :installments, :klasses do |t|
      t.index [:installment_id, :klass_id]
      t.index [:klass_id, :installment_id]
    end
  end
end
