max_retries = 3
retries = 0

begin
  Performance.transaction do
    performances = Performance.create!([
      { title: 'Hamlets', theater: 'Dailes teātris', description: 'Klasiska Šekspīra traģēdija par atriebību, mīlestību un nodevību.', performed_at: '2025-04-01 19:00' },
      { title: 'Skroderdienas Silmačos', theater: 'Nacionālais teātris', description: 'Latviešu komēdija par dzīvi laukos un precībām.', performed_at: '2025-04-03 18:30' },
      { title: 'Pūt, vējiņi!', theater: 'Liepājas teātris', description: 'Dramatiska izrāde par latviešu tautas likteni.', performed_at: '2025-04-05 20:00' },
      { title: 'Fausts', theater: 'Dailes teātris', description: 'Stāsts par cilvēka alkām pēc zināšanām un spēka.', performed_at: '2025-04-07 19:00' },
      { title: 'Zelta zirgs', theater: 'Valmieras teātris', description: 'Latviešu pasaka par drosmi, cīņu un mīlestību.', performed_at: '2025-04-09 17:00' }
    ])

    performances.each_with_index do |performance, index|
      performance.poster.attach(
        io: File.open(Rails.root.join('app/assets/images', "izrade#{index + 1}.jpg")),
        filename: "izrade#{index + 1}.jpg",
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
