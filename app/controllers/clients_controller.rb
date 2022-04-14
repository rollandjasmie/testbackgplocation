
class ClientsController < ApplicationController
  include BCrypt
  include Google::Apis::AnalyticsreportingV4
  include Google::Auth 

  before_action :set_client, only: [:show, :update, :destroy]
  before_action :authorized, only: [:infocreate,:update]
  
  # GET /info/
  def infocreate

    data = params[:value]
    # puts params[:nom]
    # puts(data.nom)
    Client.create(nom: params[:nom], prenom: params[:prenom], telephone: params[:telephone], email: params[:email],password: "123456789", email_confirmed: true)
    @idclient = Client.last
    render json: {id: @idclient}

  end

  # GET /clients
  def index
    @clients = Client.all
    @client_fiter = []
    @clients.each do |cl|
      if cl.nom
        @client_fiter.push(cl)
      end
    end
    render json: @client_fiter
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = Client.new(client_params)
    @client.password = params[:password_digest]
    begin
    if @client.save
      UserMailer.registration_confirmation(@client).deliver
      token = encode_token({client_id: @client.id})
      render json: {client: @client, token: token, message: "felicitation, veiller verifier votre mail"}
      session[:current_user_id] = @client.id
    else
      render json: {message: 'compte invalide'}, status: :unprocessable_entity
    end
    rescue ActiveRecord::RecordNotUnique => invalid
      render json: {message: 'verifiee'}
    end
    
  end
  #confirm_email-----------------
  def confirm_email
    user = Client.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      redirect_to ENV['FRONTEND_URL'] + "/login"
    else
      render json: {message: 'compte invalide'}
    end
end
  #----------------------------

  def analitique
    
    resultsFinal = []
    @client = AnalyticsReportingService.new

     
      @creds = ServiceAccountCredentials.make_creds({:json_key_io => File.open('credentials.json'),
                                                          :scope => ENV['SCOPE']})
      @client.authorization = @creds

      grr = GetReportsRequest.new
      rr = ReportRequest.new

      rr.view_id = ENV['VIEW_ID']

      #Rehefa mila filtre
      # rr.filters_expression="ga:browser=~^Firefox"

      
      pourcentageSession = Metric.new
      avgTimeOnPage = Metric.new
      session = Metric.new
      sessionDuration = Metric.new
      avgSessionDuration = Metric.new
      users = Metric.new
      entrances = Metric.new
      entranceRate = Metric.new
      pourcentageMonterUser = Metric.new
      pageViews = Metric.new
      

      pourcentageSession.expression = "ga:percentNewSessions"
      avgTimeOnPage.expression = "ga:avgTimeOnPage"
      session.expression = "ga:sessions"
      sessionDuration.expression = "ga:sessionDuration"
      avgSessionDuration.expression = "ga:avgSessionDuration"
      users.expression = "ga:users"
      entrances.expression = "ga:entrances"
      entranceRate.expression = "ga:entranceRate"
      pourcentageMonterUser.expression = "ga:bounceRate"
      pageViews.expression = "ga:pageviews"

      rr.metrics = [
        avgTimeOnPage,
        pourcentageSession,
        session,
        users,
        entrances,
        pourcentageMonterUser,
        pageViews,
        sessionDuration,
        avgSessionDuration,
        entranceRate,
      ]

      #We want this for the last 7 days
      range = DateRange.new
      range.start_date = params[:name]
      range.end_date = "today"
      rr.date_ranges = [range]

      dim = Dimension.new
      dim.name = "ga:userType"

      rr.dimensions = [
        dim
      ]
      grr.report_requests = [rr]

      response = @client.batch_get_reports(grr)
      val2 = response.reports.first.data.totals.first.values
      val = response.reports.first.column_header.metric_header.metric_header_entries

      i = 0
      lengths = val.length
      while (i < lengths)
        resultsFinal << {name: val[i].name,type: val[i].type, value: val2[i]}
        i = i + 1
      end
      


      render json: {data: resultsFinal}
      
  end
  #new_session
  def login
    @client = Client.find_by_email(params[:email]) 
    if @client && @client.authenticate(params[:password_digest])
       if @client.email_confirmed
          token = encode_token({user_id: @client.id})
          infoClient = {id: @client.id, nom: @client.nom, prenom: @client.prenom, telephone: @client.telephone, email: @client.email, email_confirmed: @client.email_confirmed, confirm_token: @client.confirm_token,}
          render json: {client: infoClient, token: token, message: 'bonjour, bienvenue'}
          session[:current_user_id] = @client.id
        else

          render json: {client: infoClient, message: 'veuiller confirmer votre email'}
        end
    else
      render json: {message: "Email ou mot de passe incorrect"}, status: 202
    end
    
  end

  def finder
    current_user = Client.find_by(session[:current_user_id])

    render json: {client: current_user, message: "welcome to welcome, session"}
  end


  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    session[:current_user_id] = nil
    render json: {message: "vous etes deconnecter"}
    # @client.destroy
    head :no_content
  end

  # def auto_login
  #   if current_client    
  #     render json: {user: @client, message: "vous etes deja conecter"} 
  #   else
  #     render json: {message: "veuiller vous connecter"}
  #   end
  # end

  # def current_client
  #   return nil if !session[:user_id] || !session[:user_id]['id']
  #   return @client if @client
  #   @client = Client.find_by_id(session[:user_id]['id'])
  # end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

   

    # Only allow a trusted parameter "white list" through.
    def client_params
      params.fetch(:client, {}).permit(:nom, :prenom, :telephone, :email, :password, :client)
    end
    
end
