class ReferralsController < ApplicationController
  before_action :set_referral, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!

  def index
    @referrals = Referral.all
  end

  def show
  end

  def new
    @referral = Referral.new
  end

  def edit
  end

  def create
    @referral = Referral.new(referral_params)
    @referral.employee_id = current_employee.id if current_employee
    puts "\n\nI am in create\n\n"
    if @referral.save
      flash[:success] = "Referral was successfully submitted"
      render :new
    else
      render :new
    end
  end

  def update
    puts "\n\nI am in update\n\n"
    if @referral.update(referral_params)
      redirect_to @referral, notice: 'Referral was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @referral.destroy
    redirect_to referrals_url, notice: 'Referral was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_referral
      @referral = Referral.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def referral_params
      params.require(:referral).permit(:first_name, :last_name, :email, :phone_number, :employee_id, :job_posting_id)
    end
end
