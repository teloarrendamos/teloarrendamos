
%w(Bicycles Surf\ Boards Hardware Motorcycles Instruments).each do |category|
  Category.where(name: category).first_or_create
end