class PeopleController < ApplicationController
  include SortableHelper

  before_action :person, only: [:edit, :add_family_member, :toggle_active,
    :add_payment, :do_add_payment, :add_payment_done, :do_add_payment_done,
    :add_debt, :do_add_debt, :new_membership_calculator]

  def index
    params[:sort] ||= 'name'
    params[:direction] ||= 'asc'
    @people = get_sorted(name: :asc)
    @people = @people.where(is_teacher: ('teachers') == params[:type]) if params[:type].present?
    case q = params[:q]
      when /\A\d+\z/ then @people = @people.where('dni LIKE ?', "%#{q}%")
      when /\A.+\z/ then @people = @people.where('name LIKE :q OR lastname LIKE :q', {q: "%#{q}%"})
    end
    @people = @people.active unless params[:include_inactive]
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
    @person_payments = @person.money_transactions.received.where(payable_id: nil)
    @payments_to_person = @person.money_transactions.done.where(payable_id: nil)
    @debts = @person.debts
  end

  def update
    if person.update_attributes(update_person_params)
      flash[:notice] = 'Guardada'
    else
      flash[:alert] = 'Error'
    end
    render action: :edit
  end

  def new_membership
    @membership = person.memberships.build
  end

  def new_membership_calculator
    calculation = @person.new_membership_amount_calculator(params[:schedules_ids])

    render json: calculation.to_json
  end

  def add_family_member
  end

  def do_add_family_member
    @other = Person.find(params[:new_family_member_id])
    person.add_family_member(@other)
  end

  def search_new_family_member
    @results = person.suggest_family(params[:q])
    render json: @results.map{|p| {label: p.to_label, value: p.id}}.to_json
  end

  def remove_family_member
    @other = Person.find(params[:family_member_id])
    person.remove_family_member(@other)
    redirect_back fallback_location: edit_person_path(person)
  end

  def toggle_active
    @person.toggle_active
    redirect_back fallback_location: people_path
  end

  def add_payment
    @trans = @person.money_transactions.received.build
    @form_url = add_payment_person_path(@person)
  end

  def add_payment_done
    @trans = @person.money_transactions.done.build
    @form_url = add_payment_done_person_path(@person)
  end

  def do_add_payment
    @trans = @person.money_transactions.received.create(money_transaction_params)
    redirect_back fallback_location: edit_person_path(@person, tab: 'person_payments')
  end

  def do_add_payment_done
    @trans = @person.money_transactions.done.create(money_transaction_params)
    redirect_back fallback_location: edit_person_path(@person, tab: 'payments_to_teacher')
  end

  def add_debt
    @debt = @person.debts.build
  end

  def do_add_debt
    @debt = @person.debts.create(create_debt_params)
    redirect_back fallback_location: edit_person_path(@person, tab: 'debts')
  end


private
  def create_person_params
    params.require(:person).permit(:name,:status,:is_teacher,:lastname,:birthday,:age,:dni,:address,:cellphone,:alt_phone,:female,:email,:group,:comments)
  end

  def update_person_params
    params.require(:person).permit(:name,:status,:is_teacher,:lastname,:birthday,:age,:dni,:address,:cellphone,:alt_phone,:female,:email,:group,:comments)
  end

  def money_transaction_params
    params.require(:money_transaction).permit(:amount, :created_at, :description)
  end

  def create_debt_params
    params.require(:debt).permit(:amount, :description, :created_at)
  end

  def person
    @person ||= Person.find(params[:id])
  end
end
