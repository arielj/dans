# typed: strong
# This is an autogenerated file for Rails routes.
# Please run rake rails_rbi:routes to regenerate.
class ActionController::Base
  include GeneratedUrlHelpers
end

module ActionView::Helpers
  include GeneratedUrlHelpers
end

class ActionMailer::Base
  include GeneratedUrlHelpers
end

module GeneratedUrlHelpers
  # Sigs for route /admins/sign_in(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_session_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_session_url(*args, **kwargs); end

  # Sigs for route /admins/sign_in(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_session_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_session_url(*args, **kwargs); end

  # Sigs for route /admins/sign_out(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def destroy_admin_session_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def destroy_admin_session_url(*args, **kwargs); end

  # Sigs for route /admins/password/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_password_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_password_url(*args, **kwargs); end

  # Sigs for route /admins/password/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_password_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_password_url(*args, **kwargs); end

  # Sigs for route /admins/password(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_password_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_password_url(*args, **kwargs); end

  # Sigs for route /admins/cancel(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def cancel_admin_registration_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def cancel_admin_registration_url(*args, **kwargs); end

  # Sigs for route /admins/sign_up(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_registration_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_admin_registration_url(*args, **kwargs); end

  # Sigs for route /admins/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_registration_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_admin_registration_url(*args, **kwargs); end

  # Sigs for route /admins(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_registration_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def admin_registration_url(*args, **kwargs); end

  # Sigs for route /
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def root_url(*args, **kwargs); end

  # Sigs for route /rooms/export(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_rooms_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_rooms_url(*args, **kwargs); end

  # Sigs for route /rooms(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rooms_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rooms_url(*args, **kwargs); end

  # Sigs for route /rooms/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_room_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_room_url(*args, **kwargs); end

  # Sigs for route /rooms/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_room_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_room_url(*args, **kwargs); end

  # Sigs for route /rooms/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def room_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def room_url(*args, **kwargs); end

  # Sigs for route /klasses/export(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_klasses_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_klasses_url(*args, **kwargs); end

  # Sigs for route /klasses/:id/toggle_active(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def toggle_active_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def toggle_active_klass_url(*args, **kwargs); end

  # Sigs for route /klasses/:id/assign_teachers(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def assign_teachers_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def assign_teachers_klass_url(*args, **kwargs); end

  # Sigs for route /klasses/:id/remove_teacher/:teacher_id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def remove_teacher_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def remove_teacher_klass_url(*args, **kwargs); end

  # Sigs for route /klasses/:id/export_students(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_students_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_students_klass_url(*args, **kwargs); end

  # Sigs for route /klasses(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def klasses_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def klasses_url(*args, **kwargs); end

  # Sigs for route /klasses/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_klass_url(*args, **kwargs); end

  # Sigs for route /klasses/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_klass_url(*args, **kwargs); end

  # Sigs for route /klasses/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def klass_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def klass_url(*args, **kwargs); end

  # Sigs for route /packages/export(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_packages_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_packages_url(*args, **kwargs); end

  # Sigs for route /packages(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def packages_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def packages_url(*args, **kwargs); end

  # Sigs for route /packages/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_package_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_package_url(*args, **kwargs); end

  # Sigs for route /packages/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_package_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_package_url(*args, **kwargs); end

  # Sigs for route /packages/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def package_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def package_url(*args, **kwargs); end

  # Sigs for route /people/new_teacher(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_teacher_people_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_teacher_people_url(*args, **kwargs); end

  # Sigs for route /people/new_student(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_student_people_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_student_people_url(*args, **kwargs); end

  # Sigs for route /people/export(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_people_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def export_people_url(*args, **kwargs); end

  # Sigs for route /people/:id/new_membership(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/new_membership_calculator(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_calculator_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_calculator_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/search_new_family_member(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_new_family_member_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def search_new_family_member_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/add_family_member(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_family_member_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_family_member_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/remove_family_member(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def remove_family_member_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def remove_family_member_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/toggle_active(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def toggle_active_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def toggle_active_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/add_payment(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/add_payment_done(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_done_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_done_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/add_debt(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_debt_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_debt_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/add_payments(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payments_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payments_person_url(*args, **kwargs); end

  # Sigs for route /people(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def people_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def people_url(*args, **kwargs); end

  # Sigs for route /people/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_person_url(*args, **kwargs); end

  # Sigs for route /people/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_person_url(*args, **kwargs); end

  # Sigs for route /people/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def person_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def person_url(*args, **kwargs); end

  # Sigs for route /money_transactions(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def money_transactions_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def money_transactions_url(*args, **kwargs); end

  # Sigs for route /money_transactions/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_money_transaction_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_money_transaction_url(*args, **kwargs); end

  # Sigs for route /money_transactions/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_money_transaction_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_money_transaction_url(*args, **kwargs); end

  # Sigs for route /money_transactions/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def money_transaction_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def money_transaction_url(*args, **kwargs); end

  # Sigs for route /close_daily_cash(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def close_daily_cash_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def close_daily_cash_url(*args, **kwargs); end

  # Sigs for route /receipt/:number(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def receipt_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def receipt_url(*args, **kwargs); end

  # Sigs for route /memberships/:id/add_installments(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_installments_membership_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_installments_membership_url(*args, **kwargs); end

  # Sigs for route /memberships(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def memberships_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def memberships_url(*args, **kwargs); end

  # Sigs for route /memberships/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_membership_url(*args, **kwargs); end

  # Sigs for route /memberships/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_membership_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_membership_url(*args, **kwargs); end

  # Sigs for route /memberships/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def membership_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def membership_url(*args, **kwargs); end

  # Sigs for route /installments/:id/new_payment(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_payment_installment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_payment_installment_url(*args, **kwargs); end

  # Sigs for route /installments/:id/add_payment(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_installment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_installment_url(*args, **kwargs); end

  # Sigs for route /installments(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def installments_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def installments_url(*args, **kwargs); end

  # Sigs for route /installments/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_installment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_installment_url(*args, **kwargs); end

  # Sigs for route /installments/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_installment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_installment_url(*args, **kwargs); end

  # Sigs for route /installments/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def installment_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def installment_url(*args, **kwargs); end

  # Sigs for route /debts/:id/add_payment(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_debt_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def add_payment_debt_url(*args, **kwargs); end

  # Sigs for route /debts(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def debts_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def debts_url(*args, **kwargs); end

  # Sigs for route /debts/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_debt_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_debt_url(*args, **kwargs); end

  # Sigs for route /debts/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_debt_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_debt_url(*args, **kwargs); end

  # Sigs for route /debts/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def debt_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def debt_url(*args, **kwargs); end

  # Sigs for route /reports/daily_cash(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_daily_cash_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_daily_cash_url(*args, **kwargs); end

  # Sigs for route /reports/payments(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_payments_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_payments_url(*args, **kwargs); end

  # Sigs for route /reports/receipts(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_receipts_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_receipts_url(*args, **kwargs); end

  # Sigs for route /reports/students_hours(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_students_hours_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_students_hours_url(*args, **kwargs); end

  # Sigs for route /reports/debts(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_debts_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_debts_url(*args, **kwargs); end

  # Sigs for route /reports/installments(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_installments_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def reports_installments_url(*args, **kwargs); end

  # Sigs for route /settings(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_url(*args, **kwargs); end

  # Sigs for route /settings/setting(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_setting_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_setting_url(*args, **kwargs); end

  # Sigs for route /settings/add_price(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_add_price_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def settings_add_price_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/mandrill/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mandrill_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/postmark/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_postmark_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_postmark_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/relay/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_relay_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_relay_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/sendgrid/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_sendgrid_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_sendgrid_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mailgun_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_mailgun_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_emails_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_emails_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/new(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def new_rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def edit_rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/inbound_emails/:id(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_url(*args, **kwargs); end

  # Sigs for route /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_reroute_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_conductor_inbound_email_reroute_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/blobs/:signed_id/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_service_blob_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_blob_representation_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_key/*filename(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/disk/:encoded_token(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def update_rails_disk_service_url(*args, **kwargs); end

  # Sigs for route /rails/active_storage/direct_uploads(.:format)
  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_path(*args, **kwargs); end

  sig { params(args: T.untyped, kwargs: T.untyped).returns(String) }
  def rails_direct_uploads_url(*args, **kwargs); end
end
