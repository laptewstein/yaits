module ResponseHelpers
  # @return [Hash] the body of the response parsed into a hash from JSON.
  def json_response
    result = JSON.parse(response.body)
    result.is_a?(Hash) ? result.with_indifferent_access : result
  end
end
