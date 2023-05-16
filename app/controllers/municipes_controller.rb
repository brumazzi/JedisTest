class MunicipesController < ApplicationController
  before_action :set_municipe, only: %i[show edit update destroy]

  # GET /municipes or /municipes.json
  def index
    @municipes = Municipe.filter_by(params[:search])
  end

  # GET /municipes/1 or /municipes/1.json
  def show; end

  # GET /municipes/new
  def new
    @municipe = Municipe.new
    @municipe.address = Address.new
  end

  # GET /municipes/1/edit
  def edit; end

  # POST /municipes or /municipes.json
  def create
    @municipe = Municipe.new(municipe_params)

    respond_to do |format|
      if @municipe.save
        format.html { redirect_to edit_municipe_path(@municipe), notice: 'Municipe Salvo.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /municipes/1 or /municipes/1.json
  def update
    respond_to do |format|
      if @municipe.update(municipe_params)
        format.html { redirect_to edit_municipe_path(@municipe), notice: 'Municipe Salvo.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_municipe
    @municipe = Municipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def municipe_params
    params.require(:municipe).permit(:name, :cpf, :cns, :email, :birth, :phone, :status, :picture,
                                     address_attributes: %i[cep city state neighborhood street number complement municipe_id ibge])
  end
end