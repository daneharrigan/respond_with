class ItemSerializer < Serialize
  structure do
    {
      name: name,
      type: type,
      size: size
    }
  end
end
