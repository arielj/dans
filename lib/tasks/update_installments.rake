desc 'Store membership details'
task update_installments: :environment do
  Installment.includes(:membership).where(year: 2026, month: :april).each do |ins|
    ins.membership_amounts = ins.membership.amounts
    ins.save
  end
end
