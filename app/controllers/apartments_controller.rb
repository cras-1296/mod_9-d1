class ApartmentsController < ApplicationController
  before_action :find_building

  def index
    @building = Building.find params[:building_id]
    @apartments = @building.apartments # Se muestran los apartments asociados a este building
  end

  def new
    @building = Building.find params[:building_id]
    @apartment = Apartment.new
  end

  def create
    @apartment = Apartment.new(apartment_params) #Strong parameters, previene ataques de mass assignment
    @apartment.building = @building #Asignamos el building, ya no es necesario pasarlo en el formulario, ahora viene en la url
    respond_to do |format|
      if @apartment.save
        format.html { redirect_to building_apartment_path(@building, @apartment), notice: 'Apartment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def show
    @building = Building.find params[:building_id]
    @apartment = Apartment.find(params[:id])    
  end

  def edit
    @building = Building.find params[:building_id]
    @apartment = Apartment.find params[:id]
  end

  def update
    @building = Building.find params[:building_id]
    @apartment = Apartment.find params[:id]

    respond_to do |format|
      if @apartment.update(apartment_params.merge(building: @building)) #Se añade el building que se obtuvo en la llamada a find_building
        format.html { redirect_to building_apartment_path(@building, @apartment), notice: 'Apartment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @apartment = Apartment.find params[:id]
    @apartment.destroy
    
    respond_to do |format|
      format.html { redirect_to building_apartments_url, notice: 'Apartment was successfully destroyed.' }
    end
  end
  

  private
  def apartment_params
    params.require(:apartment).permit(:number)
  end

  def find_building
    @building = Building.find params[:building_id]
  end
end
