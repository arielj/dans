# frozen_string_literal: true

class PeopleController < ApplicationController
  include SortableHelper

  def index
    params[:sort] ||= 'name'
    params[:direction] ||= 'asc'
    @type = params[:type] || 'students'

    @people = get_sorted(name: :asc)
    @people = @people.where(is_teacher: @type == 'teachers') if @type != 'all'
    @people = @people.search(params[:q]) if params[:q].present?
    @people = @people.active unless params[:include_inactive]
  end

  def export
    index
    send_file ExcelExporter.to_xls(@people)
  end

  def new_student
    @person = Person.new is_teacher: false
    render template: 'people/new'
  end

  def new_teacher
    @person = Person.new is_teacher: true
    render template: 'people/new'
  end

  def create
    @person = Person.new create_person_params
    if @person.save
      redirect_to edit_person_path(@person)
    else
      render action: :new
    end
  end

  def edit
    @person_payments = person.money_transactions.received.where(payable_id: nil).order(created_at: :desc)
    @payments_to_person = person.money_transactions.done.where(payable_id: nil).order(created_at: :desc)
    @debts = person.debts
    @membership = person.memberships.where(id: params[:membership_id]).first || person.memberships.first
  end

  def update
    if person.update(update_person_params)
      flash[:notice] = tg("saved.#{person.type}", person.gender)
    else
      flash[:error] = 'Error'
    end
    redirect_to action: :edit
  end

  def new_membership
    @membership = person.memberships.build

    month = DateTime.current.month

    from = Setting.fetch(:preselected_installments_month_from, :january)
    from = Installment.month_sym(month) if Installment.month_num(from) < month
    @membership.create_installments_from = from

    to = Setting.fetch(:preselected_installments_month_to, :december)
    to = Installment.month_sym(month) if Installment.month_num(to) < month
    @membership.create_installments_to = to
  end

  def new_membership_calculator
    calculation =
      person.new_membership_amount_calculator(
        params[:schedules_ids],
        params[:use_non_regular_fee] == '1',
        use_fees_with_discount: params[:use_fees_with_discount] == '1'
      )

    render json: calculation.to_json
  end

  def add_family_member; end

  def do_add_family_member
    @other = Person.find(params[:new_family_member_id])
    person.add_family_member(@other)
  end

  def search_new_family_member
    @results = person.suggest_family(params[:q])
    render json: @results.map { |p| { label: p.to_label, value: p.id } }.to_json
  end

  def remove_family_member
    @other = Person.find(params[:family_member_id])
    person.remove_family_member(@other)
    redirect_back fallback_location: edit_person_path(person)
  end

  def toggle_active
    person.toggle_active
    redirect_back fallback_location: people_path
  end

  def add_payment
    @trans = person.money_transactions.received.build
    @form_url = add_payment_person_path(person)
  end

  def add_payment_done
    @trans = person.money_transactions.done.build
    @form_url = add_payment_done_person_path(person)
  end

  def do_add_payment
    @trans = person.money_transactions.received.create(money_transaction_params)
    redirect_back fallback_location: edit_person_path(person, tab: 'person_payments')
  end

  def do_add_payment_done
    @trans = person.money_transactions.done.create(money_transaction_params)
    redirect_back fallback_location: edit_person_path(person, tab: 'payments_to_teacher')
  end

  def add_payments
    @unpaid_installments = person.installments_for_multi_payments
  end

  def do_add_payments
    @result = person.add_multi_payments(params[:installments_to_pay], params[:amount], params[:ignore_recharge])

    if @result.is_a?(Array)
      flash[:notice] = t('saved.payments')

      options = { tab: :memberships }

      if params[:button] == 'save_and_receipt'
        new_receipt_num = MoneyTransaction.last_receipt + 1
        @result.each do |payment|
          payment.update_column :receipt, new_receipt_num
        end
        options[:show_receipt] = new_receipt_num
      end

      @redirect_to = edit_person_path(person, options)
    end
  end

  def add_debt
    @debt = person.debts.build
  end

  def do_add_debt
    @debt = person.debts.create(create_debt_params)
    redirect_back fallback_location: edit_person_path(person, tab: 'debts')
  end

  def person
    @person ||= Person.find(params[:id])
  end
  helper_method :person

  private

  def create_person_params
    params
      .require(:person)
      .permit(:name, :status, :is_teacher, :lastname, :birthday, :age, :address,
              :dni, :cellphone, :alt_phone, :gender, :email, :group, :comments)
  end

  def update_person_params
    params
      .require(:person)
      .permit(:name, :status, :is_teacher, :lastname, :birthday, :age, :address,
              :dni, :cellphone, :alt_phone, :gender, :email, :group, :comments)
  end

  def money_transaction_params
    params
      .require(:money_transaction).permit(:amount, :created_at, :description)
  end

  def create_debt_params
    params.require(:debt).permit(:amount, :description, :created_at)
  end
end
