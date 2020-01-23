desc 'Migrates all old data to the new models'
task migrate_all: :environment do
  OldSetting.to_new
  OldRoom.find_each(&:to_new)
  OldKlass.find_each(&:to_new)
  OldPackage.find_each(&:to_new)
  OldUser.find_each(&:to_new)
  OldMembership.find_each(&:to_new)
  OldInstallment.find_each(&:to_new)
  OldDebt.find_each(&:to_new)
  OldMovement.find_each(&:to_new)
  OldPayment.find_each(&:to_new)
end
