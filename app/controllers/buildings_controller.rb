class BuildingsController < ApplicationController
  def index
      @buildings = Building.all
  end
      
    def new
      @building = Building.new
      3.times {@building.apartments.build} 
      # Esto crea una nueva instancia de Building y tres instancias de Apartment que pertenecen al Building.
    end
    
    def create
      @building = Building.new(building_params)
      if @building.save
        redirect_to building_path(@building)
      else
        render ‘new’
      end
    end

    def show
      @building = Building.find params[:id]
    end

    def edit
      @building = Building.find params[:id]
    end

    def update
      @building = Building.find params[:id]
      respond_to do |format|
        if @building.update_attribute(building_params)
          format.html { redirect_to building_path(@building), notice: 'Building was successfully updated.' }
        else
          format.html { render :edit }
        end
      end
    end

    def destroy
      @building = Building.find params[:id]
      @building.destroy
      respond_to do |format|
        format.html { redirect_to buildings_url, notice: 'Building was successfully destroyed.' }
      end
    end
    
    private
    def building_params
        # Esto permite que los atributos de apartment sean guardados.
        # El parametró destroy  nos permite eliminar un apartment cuando se envia el formulario.
        params.require(:building).permit(:name, apartments_attributes: [:id, :number, :_destroy])
    end
  end    