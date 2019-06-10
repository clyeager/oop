#modify the code so that any attempt to view data from the first class results in
#a log being generated

class SecretFile
  def initialize(secret_data, log)
    @data = secret_data
    @log = log
  end

  def data
    @log.create_log_entry(Time.now)
    @data
  end
end

class SecurityLogger
  def initialize
    @tracker = []
  end

  def create_log_entry(time)
    self.tracker << time
  end
end

log = SecurityLogger.new
file = SecretFile.new('hi there', log)
file.data


























