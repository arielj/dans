class PeopleController < ApplicationController
  def index
    @people = Person.all
    @people = @people.where(is_teacher: (params[:type] == 'teachers')) if params[:type].present?
    case q = params[:q]
      when /\A\d+\z/ then @people = @people.where('dni LIKE ?', "%#{q}%")
      when /\A.+\z/ then @people = @people.where('name LIKE :q OR lastname LIKE :q', {q: "%#{q}%"})
    end
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
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(update_person_params)
      flash[:notice] = 'Guardada'
    else
      flash[:alert] = 'Error'
    end
    render action: :edit
  end

private
  def create_person_params
    params.require(:person).permit(:name,:status,:is_teacher,:lastname,:birthday,:age,:dni,:address,:cellphone,:alt_phone,:female,:email,:group,:comments)
  end

  def update_person_params
    params.require(:person).permit(:name,:status,:is_teacher,:lastname,:birthday,:age,:dni,:address,:cellphone,:alt_phone,:female,:email,:group,:comments)
  end
end
