module FreshProxy
  def get_proxy
    totalproxies = Proxy.where(:bad => false).count
    random = rand(1+totalproxies)
    @choice =Proxy.limit(1).offset(random).where(:bad => false)
    @proxy = @choice[0]
    @ip = @proxy.ip
    @port = @proxy.port.to_i
    return @ip, @port, @proxy.id
  end
end