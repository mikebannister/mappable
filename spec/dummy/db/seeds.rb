module Mappable
  [Map, Mapping].each do |model|
    ids = model.all.map(&:id)
    model.delete(ids)
  end

  account_map = Map.create(name: 'account', attr: 'name', from: 'legacy', to: 'current')
  employee_map = Map.create(name: 'employee', attr: 'name', from: 'legacy', to: 'current')

  Mapping.create(map: account_map, from: 'old account name', to: 'new account name')
  Mapping.create(map: employee_map, from: 'old employee name', to: 'new employee name')
end
