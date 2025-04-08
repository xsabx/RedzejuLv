max_retries = 3
retries = 0
begin
  Bike.transaction do
    bikes = Bike.create!([
      { name: 'Revel Rascal XO Transmission', bike_type: 'Mountain', frame_size: 'Large' },
      { name: 'Yeti SB140 LR T2 TURQ', bike_type: 'Mountain', frame_size: 'Medium' },
      { name: 'Merida Reacto 4000', bike_type: 'Road', frame_size: 'Large' },
      { name: 'Specialized Sirrus X 4.0', bike_type: 'Hybrid', frame_size: 'Small' },
      { name: 'Gazelle Medeo T10 HMB', bike_type: 'Electric', frame_size: 'Medium' },
      { name: 'Liv Lurra 29', bike_type: 'Mountain', frame_size: 'Small' },
      { name: 'Giant TCR Advanced Pro 2', bike_type: 'Road', frame_size: 'Large' },
      { name: 'Whyte Rheo 1 V1', bike_type: 'Hybrid', frame_size: 'Medium' },
      { name: 'Gazelle Ultimate C380 HMB', bike_type: 'Electric', frame_size: 'Medium' },
      { name: 'Ultimate CF SL 7 AXS', bike_type: 'Road', frame_size: 'Small' }
    ])
    
    bikes.each_with_index do |bike, index|
      bike.image.attach(
        io: File.open(Rails.root.join('app/assets/images', "bike#{index+1}.jpg")),
        filename: "bike#{index+1}.jpg",
        content_type: 'image/jpeg'
      )
    end
  end
rescue ActiveRecord::StatementInvalid => e
  if retries < max_retries
    retries += 1
    sleep(1)
    retry
  else
    raise e
  end
end
