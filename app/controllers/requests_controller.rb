class RequestsController < ApplicationController

  def index
    @requests = Request.all
  end

  def new
    @request = Request.new
  end

  def show
    @request = Request.find(params[:id])
    @job = Job.find(@request.job_id)
  end

  def create
    @request = Request.new(requests_params)
    if @request.save!
      flash[:notice] = "All good"
      redirect_to job_worker_profiles_path(@request.job)
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit
    @request = Request.find(params[:id])
    @job = Job.find(@request.job_id)
  end

  def update
    @request = Request.find(params[:id])
    @request.update(requests_params)
    if @request.status == "accepted"
      flash[:notice] = "request accepted"
    else
     flash[:notice] = "request cancelled"
    end
    redirect_to dashboard_workers_path
  end

  def price

  end

  # monetize :price_cents

  private

  def requests_params
    params.require(:request).permit(:worker_profile_id, :job_id, :status, :hours, :start_time, :material_cost, :time )
  end




end
