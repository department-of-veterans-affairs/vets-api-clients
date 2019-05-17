class ServiceHistory
  Deployment = Struct.new(:start_date, :end_date, :location)

  attr_reader :id, :branch_of_service, :start_date, :end_date, :discharge_status, :deployments
  def initialize(resource_object)
    @id = resource_object['id']
    attributes = resource_object['attributes']
    @branch_of_service = attributes['branch_of_service']
    @start_date = Date.parse(attributes["start_date"])
    @end_date = Date.parse(attributes["end_date"])
    @discharge_status = attributes["discharge_status"]

    @deployments = attributes["deployments"].map do |deployment|
      Deployment.new(Date.parse(deployment['start_date']), Date.parse(deployment['end_date']), deployment['location'])
    end
  end
end