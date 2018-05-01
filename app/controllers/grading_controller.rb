class GradingController < ApplicationController
  def grade_my_code
    name = params["upload"]['datafile'].original_filename
    type = get_langid(name.split('.')[1])
    file = params["upload"]['datafile'].tempfile

    restclientpost = RestClient.post( 'http://localhost:4000/compile',
      {:langid => type,
        :codefile => file
      })

    @answer = restclientpost.body

    render :answer
  end

  def get_langid(type)
    case type
    when 'js'
      return 0
    when 'java'
      return 1
    when 'rb'
      return 2
    end
  end

end
