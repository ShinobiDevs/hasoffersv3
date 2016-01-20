class HasOffersV3
  class Employee < Base
    def find_all(params = {})
      post_request 'findAll', params
    end

    def find_all_by_ids(params = {})
      requires! params, [:ids]
      post_request 'findAllByIds', params
    end

    def find_by_id(params = {})
      requires! params, [:id]
      post_request 'findById', params
    end
  end
end
