module SharedMethods
  
  # define creation week for a model
    def week
      self.created_at.strftime('%W')
    end

end