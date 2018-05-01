# frozen_string_literal: true

# Concern for the advanced search methods including
# the dsl query constructor and the search method
module AdvancedSearchHelper
  # Make a search on Elasticsearch
  def elastic_search_results(model)
    if params[:q].respond_to?(:to_hash)
      model.search(create_dsl_query)
    else
      model.search(params[:q])
    end.page(params[:page]).records
  end

  # Create a query in DLS for Elasticsearch
  def create_dsl_query
    # Added q_param so we only permit certain params on search and be able to use them as a hash
    {
      query: {
        bool: { must: parse_dls_query_params }
      }
    }
  end

  # Create a hash with the dsl query for Elasticsearch
  # managing the query for the dates
  def parse_dls_query_params
    q_params.to_hash.map do |k, v|
      create_query_hash(k, v) unless v.blank?
    end.compact
  end

  # Create the hash with the query content
  # based on the k: key and v: Value, sent
  # as parameters
  def create_query_hash(k, v)
    if v.respond_to? :to_hash
      clean_hash = v.delete_if { |_l, w| w.blank? }
      if clean_hash.length == 1
        create_match_hash(k, clean_hash.first[1])
      else
        create_range_hash(k, v)
      end
    else
      create_match_hash(k, v)
    end
  end

  # Create a match hash based on the k: Key
  # and v: Value
  def create_match_hash(k, v)
    { match: { k.to_sym => v } }
  end

  # Create a range hash based on the k: Key
  # and v: Value
  def create_range_hash(k, v)
    { range: { k.to_sym => {
      gte: v['start_date'],
      lte: v['end_date']
    } } }
  end
end
